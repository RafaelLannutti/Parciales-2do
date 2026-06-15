[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/9AsqjP2W)
# Parcial 2 Comisión 1– Objetos 1 – Unahur – 2025 – Primer Cuatrimestre

## Dominio: Artistas Digitales, Galerías y Exhibiciones
En la era digital, los artistas visuales y multimedia utilizan plataformas online para mostrar su obra, atraer público y crecer en su carrera. Queremos modelar este ecosistema de artistas, galerías y exhibiciones en línea, para comprender sus comportamientos, interacciones y evolución profesional.

## 🧑‍🎨 Escenario
Cada artista digital está asociado a una galería principal (como DeviantArt, Behance o ArtStation) y puede realizar distintos tipos de exhibiciones que le permiten aumentar su cantidad de seguidores.
Los tipos de exhibición actualmente disponibles son:
- 🖼️ Ilustración: El impacto se calcula como el nivel de técnica visual del artista multiplicado por 4.

- 🎬 Animación: El impacto se calcula como su creatividad multiplicada por 5, más un adicional que depende del tipo de animación:
    - 2D tradicional: suma 10.
    - 3D: no suma adicional.
    - Motion graphics: suma 7.

- 🧪 Experimental: Instalaciones interactivas, arte generativo, etc. El impacto es el promedio entre creatividad y técnica visual, multiplicado por 6.

Cada artista tiene las siguientes características (valores de 0 a 100):
- creatividad
- técnica visual
- dominio digital

También se conoce su seudónimo (string único), que no puede cambiarse.

Por ahora se reconocen 3 tipos de artista (en el futuro podrían surgir más):

## 👨‍🏫 Tipos de Artista
- **Artista consagrado**: Siempre exhibe en un mismo tipo de formato (ilustración, animación, experimental, u otros futuros). Para que un artista pueda ser registrado con este rol, debe tener más seguidores que el mínimo establecido por el CCAA (Consejo de Calidad de Arte Audiovisual). Si no cumple, se arroja un error.

- **Artista versátil**: Puede cambiar el tipo de exhibición libremente y tantas veces como quiera.

- **Artista estratégico**: Realiza exhibiciones del tipo que le generen más impacto posible, entre aquellos tipos que ya conoce. Para registrar un artista estratégico debe conocer al menos un tipo de exhibición. Puede aprender un nuevo tipo haciendo una exhibición de exploración (indicando el tipo), que le permite agregar ese tipo como aprendido, pero pierde un 8% de sus seguidores. Esta exhibición no se registra en la galería.

## 🖼️ Galerías
Cada galería online permite registrar artistas, y no puede haber dos artistas con el mismo seudónimo. Las galerías pueden ser:
- **Abiertas**: Aceptan todo tipo de artista.

- **Curadas**: Solo aceptan artistas con más de el triple del mínimo definido por el CCAA.


Cada vez que un artista realiza una exhibición, gana seguidores según el impacto, y mejora sus habilidades en función del tipo de exhibición:
- Ilustración: +2 técnica visual
- Animación: +2 creatividad
- Experimental: +1 creatividad, +2 técnica visual

Al registrar una exhibición, se indica el artista (debe estar previamente registrado en la galería, si no se arroja un error) y la audiencia máxima alcanzada.

## 🧪 Se pide probar mediante test que una galería pueda cumplir las siguientes funcionalidades:
1. Registrar un nuevo artista estratégico en una galería (x) que ya conoce solo el tipo experimental. Verificar que x tiene 1 artista registrado.
2. Realizar una exhibición de exploración para ese artista estratégico con el tipo ilustración y verificar que ahora conoce 2 tipos de exhibición.
3. Registrar un nuevo artista consagrado en la galería x que realice exhibiciones de tipo ilustración. Hacer una exhibición y verificar que actualiza correctamente los seguidores.
4. Realizar una nueva exhibición en una galería (x) con un artista versátil que elija hacer animación del tipo "motion graphics". Verificar que se actualicen bien los seguidores.
5. Obtener la lista de artistas de una galería abierta que califican para pasar a una galería curada.
6. Informar la cantidad total de seguidores de una galería.
7. Devolver el seudónimo del artista que haya obtenido mayor audiencia en una exhibición en esa galería.
8. Reasignar a los 3 mejores artistas (con más seguidores) desde una galería abierta a una galería curada, si cumplen las condiciones.
