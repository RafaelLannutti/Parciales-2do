object ilustracion {
    method impacto(unArtista) = unArtista.tecnicaVisual()*4
    method mejorarHabilidades(unArtista) { unArtista.mejoraTecnicaVisual(2)}
}

class Animacion {
    method impacto(unArtista) = unArtista.creatividad()*5
    method mejorarHabilidades(unArtista) { unArtista.mejoraCreatividad(2)}
}

class Animacion2D inherits Animacion{
     override method impacto(unArtista) = super(unArtista) + 10
}

class Animacion3D inherits Animacion{
     override method impacto(unArtista) = super(unArtista) + 0
}

class AnimacionMotion inherits Animacion{
     override method impacto(unArtista) = super(unArtista) + 7 
}

object experimental{
    method impacto(unArtista) = ((unArtista.creatividad()+unArtista.creatividad())/2)*6
    method mejorarHabilidades(unArtista){
        unArtista.mejoraCreatividad(1)
        unArtista.mejoraTecnicaVisual(2)
    }
}

// Artistas

class Artista{
    var seguidores = 0
    var creatividad = 0
    var tecnicaVisual = 0
    var dominioDigital = 0
    const property seudonimo
    method seguidores() = seguidores
    method exhibir(unaExhibicion)
    method creatividad() = creatividad
    method tecnicaVisual() = tecnicaVisual
    method dominioDigital() = dominioDigital
    method mejoraTecnicaVisual(valor) {tecnicaVisual += valor}
    method mejoraCreatividad(valor) {creatividad += valor}
    method mejoraDominioDigital(valor) {dominioDigital += valor}
    method puedeExhibir(unaExhibicion) = true

}

class Consagrado inherits Artista{
     const formatoDeExhibicion
    method initialize() {
        if (seguidores < ccaa.requisitoSeguidores()){
            self.error("el artista no tiene los seguidores minimos necesarios")
        }
      
    }
    

    override method exhibir(unaExhibicion) {
        if(self.puedeExhibir(unaExhibicion)){
            seguidores += unaExhibicion.impacto(self)
            unaExhibicion.mejorarHabilidades(self)
        }
    }
    override method puedeExhibir(unaExhibicion) = formatoDeExhibicion == unaExhibicion

}

class Versatil inherits Artista{
    var formatoDeExhibicion

    method cambiarFormatoDeExihicion(nuevoFormato){formatoDeExhibicion = nuevoFormato}

    override method exhibir(unaExhibicion) {
        seguidores += unaExhibicion.impacto(self)
        unaExhibicion.mejorarHabilidades(self)
    }

}

class Estrategico inherits Artista{
    const tipoDeExhibicionQueConoce = #{}
    method initialize() {
        if (tipoDeExhibicionQueConoce.size() == 0){
            self.error("el artista debe conocer al menos un tipo de exhibicion")
        }
    }

    method aprenderNuevoFormatoExhibicion(nuevoFormato) {
        if(not tipoDeExhibicionQueConoce.contains(nuevoFormato)){
            self.exihibicionDeExploracion(nuevoFormato)
        }
    }

    method exihibicionDeExploracion(nuevaExhibicion) {
        tipoDeExhibicionQueConoce.add(nuevaExhibicion)
        seguidores = seguidores * 0.92
    }

    override method exhibir(unaExhibicion) {
        if(self.puedeExhibir(unaExhibicion)){
            seguidores += unaExhibicion.impacto(self)
            unaExhibicion.mejorarHabilidades(self)
        }
    }
    override method puedeExhibir(unaExhibicion) = tipoDeExhibicionQueConoce.contains(unaExhibicion)

    method cantidadDeExhibicionQueConoce() = tipoDeExhibicionQueConoce.size()
}

object ccaa {
  var seguidoresMinimos = 9
  method requisitoSeguidores() = seguidoresMinimos
  method cambiarSeguidoresMinimos(nuevoValor){seguidoresMinimos = nuevoValor}
}


//Galerias

class RegistroExhibicion{
    const property artista 
    const property audienciaMaxima
}

class Galeria{
    const property registroArtistas = []
    const property registroDeExihibicoines = []

    method registrarArtista(unArtista) {
      if(not registroArtistas.contains(unArtista.seudonimo())){
        registroArtistas.add(unArtista)
      }
    }
    method cantidadArtistasRegistrados() = registroArtistas.size()

    method hacerExhibicionPorArtista(unArtista, unaExhibicion, audienciaMaximaObtenida){
        if(unArtista.puedeExhibir(unaExhibicion))
            unArtista.exhibir(unaExhibicion)
            registroDeExihibicoines.add(new RegistroExhibicion(artista = unArtista, audienciaMaxima = audienciaMaximaObtenida))
    }

    method cantidadTotalDeSeguidoresDeGaleria() = registroArtistas.sum({artista => artista.seguidores()})
    method artistaConMayorAudiencia() = registroDeExihibicoines.max({audiencia => audiencia.audienciaMaxima()}).artista().seudonimo()
    method quitarArtista(unArtista) {registroArtistas.remove(unArtista)}
    method artistasQueCalificanParaGaleriaCurada()
}

class Abierta inherits Galeria{
    override method artistasQueCalificanParaGaleriaCurada() = registroArtistas.filter({artista => artista.seguidores() > (3 * ccaa.requisitoSeguidores())})
    method artistaConMasSeguidoresParaCurada() = self.artistasQueCalificanParaGaleriaCurada().max({artista => artista.seguidores()})
    method reasignarACurada(galeriaCurada) {
      const artistasAReasignar = self.artistasQueCalificanParaGaleriaCurada()
      artistasAReasignar.sortBy({a1,a2 => a1.seguidores() > a2.seguidores()})
      const los3ConMasSeguidores = artistasAReasignar.take(3)
      galeriaCurada.recibirLos3ConMasSeguidores(los3ConMasSeguidores)
      registroArtistas.removeAll(los3ConMasSeguidores)
    }
}

class Curada inherits Galeria{
    method recibirLos3ConMasSeguidores(listaArtistas) {
      registroArtistas.addAll(listaArtistas)
    }

override method artistasQueCalificanParaGaleriaCurada() {}
}