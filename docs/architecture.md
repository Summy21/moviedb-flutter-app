# Arquitectura del Sistema — MovieDB Flutter App

## 1. Propósito del sistema

Aplicación móvil que permite al usuario explorar películas y series
obtenidas desde la API de The Movie Database (TMDB). El usuario puede
ver listados ordenados por popularidad y evaluación, acceder al detalle
de cada título, y buscar contenido por nombre.

---

## 2. Metodología — Spec-Driven Development

Este proyecto siguió una metodología de Spec-Driven Development:
diseñar y especificar el sistema completo antes de escribir código.

El proceso fue:
1. Definir las entidades del dominio a partir de la API
2. Especificar los contratos de repositorio
3. Diseñar los flujos de estado de cada Cubit
4. Diseñar las pantallas y navegación
5. Solo entonces escribir código

Esto garantiza que cada línea de código tiene un propósito claro
y reduce las iteraciones de corrección posteriores.

---

## 3. Arquitectura — Clean Architecture

El proyecto implementa Clean Architecture con tres capas.
Las dependencias siempre apuntan hacia adentro.
Domain no conoce a Data ni a Presentation.

### DOMAIN — núcleo del sistema
Contiene las reglas de negocio puras.
No depende de Flutter, Firebase, ni ninguna librería externa.
- Entities: objetos puros de negocio
- Repository Interfaces: contratos de acceso a datos
- Use Cases: una acción de usuario por clase

### DATA — acceso a datos externos
Implementa los contratos definidos en Domain.
Conoce TMDB, Dio, y el formato JSON de la API.
- Models: DTOs con fromJson y toEntity()
- DataSource: comunicación directa con TMDB API
- Repository Implementation: convierte exceptions en Failures

### PRESENTATION — interfaz de usuario
Consume los use cases a través de Cubits.
No conoce repositorios ni datasources.
- Cubits: lógica de estado de cada pantalla
- States: sealed classes con Freezed
- Pages: pantallas de la app
- Widgets: componentes reutilizables

---

## 4. Entidades del dominio

### Movie
Representa una película en el sistema.

| Campo | Tipo | Descripción |
|---|---|---|
| id | int | Identificador único |
| title | String | Título de la película |
| overview | String | Descripción |
| posterPath | String | Path del poster |
| backdropPath | String | Path de imagen de fondo |
| voteAverage | double | Puntuación promedio (0-10) |
| voteCount | int | Número de votos |
| releaseDate | String | Fecha de estreno |
| genreIds | List<int> | IDs de géneros |

### TvShow
Representa una serie de televisión.

| Campo | Tipo | Descripción |
|---|---|---|
| id | int | Identificador único |
| name | String | Nombre de la serie |
| overview | String | Descripción |
| posterPath | String | Path del poster |
| backdropPath | String | Path de imagen de fondo |
| voteAverage | double | Puntuación promedio (0-10) |
| voteCount | int | Número de votos |
| firstAirDate | String | Fecha de primer episodio |
| genreIds | List<int> | IDs de géneros |

### MediaDetail
Representa el detalle completo de una película o serie.

| Campo | Tipo | Descripción |
|---|---|---|
| id | int | Identificador único |
| title | String | Título o nombre |
| overview | String | Descripción completa |
| posterPath | String | Path del poster |
| backdropPath | String | Path de imagen de fondo |
| voteAverage | double | Puntuación promedio |
| genres | List<String> | Nombres de géneros |
| status | String | Estado (Released, etc.) |
| tagline | String | Frase destacada |
| runtime | int? | Duración en minutos (solo movies) |
| numberOfSeasons | int? | Número de temporadas (solo tv) |
| numberOfEpisodes | int? | Número de episodios totales (solo tv) |

---

## 5. Contratos de repositorio

### IMediaRepository
Define todas las operaciones disponibles sobre medios.
Vive en domain. Su implementación vive en data.

```dart
abstract class IMediaRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, List<TvShow>>> getPopularTvShows();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();
  Future<Either<Failure, MediaDetail>> getMovieDetail(int id);
  Future<Either<Failure, MediaDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);
}
```

---

## 6. Use Cases

Un use case por acción de usuario.
Cada uno recibe el repositorio por inyección de dependencias.

| Use Case | Parámetros | Retorna |
|---|---|---|
| GetPopularMovies | NoParams | Either<Failure, List<Movie>> |
| GetTopRatedMovies | NoParams | Either<Failure, List<Movie>> |
| GetPopularTvShows | NoParams | Either<Failure, List<TvShow>> |
| GetTopRatedTvShows | NoParams | Either<Failure, List<TvShow>> |
| GetMovieDetail | MovieParams(id) | Either<Failure, MediaDetail> |
| GetTvShowDetail | TvShowParams(id) | Either<Failure, MediaDetail> |
| SearchMovies | SearchParams(query) | Either<Failure, List<Movie>> |
| SearchTvShows | SearchParams(query) | Either<Failure, List<TvShow>> |

---

## 7. Flujo de estados por Cubit

### MoviesState y TvShowsState
Mismo patrón para películas y series.

## 8. Pantallas y navegación

### Home Page
- TabBar con dos tabs: Peliculas y Series
- Cada tab tiene dos filtros: Popular y Mejor evaluadas
- Grid de tarjetas con poster, titulo y puntuacion
- Boton de busqueda en AppBar

### Detail Page
- Imagen de fondo con degradado
- Poster superpuesto
- Titulo, puntuacion, generos, descripcion
- Hero animation desde el card al detalle

### Search Page
- Campo de texto con busqueda
- Resultados de peliculas y series
- Mismo card que en Home

### Navegacion
- Home → Detail (con Hero animation)
- Home → Search
- Search → Detail

---

## 9. Inyección de dependencias

GetIt como service locator.
Orden de registro:

1. DioClient (singleton)
2. IMediaDataSource → TmdbDataSource (lazySingleton)
3. IMediaRepository → MediaRepositoryImpl (lazySingleton)
4. Use Cases (lazySingleton)
5. Cubits (factory)

## 10. Decisiones técnicas

| Decisión | Alternativa considerada | Por qué esta |
|---|---|---|
| Cubit | Bloc | Flujos simples sin transformaciones de eventos complejas |
| GetIt | Provider, Riverpod | Familiar, simple, sin dependencia del árbol de widgets |
| Dio | http package | Interceptores, manejo de errores centralizado, más control |
| Freezed | Manual | Elimina boilerplate de sealed classes y states |
| dartz Either | Excepciones | Fuerza manejo explícito de errores en compilación |
| go_router | Navigator 2.0 | Declarativo, más limpio para rutas nombradas |
| cached_network_image | Image.network | Caché automático de imágenes, placeholders y error widgets |

---

## 11. Flujo completo de una petición




