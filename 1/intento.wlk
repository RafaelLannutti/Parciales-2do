class Equipo{
    const nombre
    const energiaBase
    const entrenador 
    const tecnologias = []

    method energiaTotal(){
        const energia = energiaBase  +  self.valorEnergiaTecnologiasActivas() 
        return energia + self.condicionAdicional(energia) 
    }

    method tecnologiasActivas(){
        return tecnologias.filter({t => t.activa()})
    }
    method valorEnergiaTecnologiasActivas() {
      return self.tecnologiasActivas().sum({t => t.valorEnergetico()})
    }

    method condicionAdicional(energia)
    method esDePrestigioUniversal()
    method tieneTecnologia(){
        return !tecnologias.isEmpty()
    }
    method todasLasTecnologiasActivas() {
      return tecnologias.all({t => t.activa()})
    }
}

class Luminico inherits Equipo{
  const radiacion
  const cristales = []

  override method condicionAdicional(energia) {
   return if (radiacion <= 5000){ energia *0.1 }else {0}
  }

    method cantidadcristales(){
        return cristales.size()
    }

    override method esDePrestigioUniversal() {
      return self.cantidadcristales() >=3 &&
            entrenador.esEliteGalactica() &&
            self.tieneTecnologia()

    }

}

class Sintetico inherits Equipo{
  const procesamiento
  const modulosActivos
  var certificado = false

  method estaCertificado(){
    return certificado
  }

  override method condicionAdicional(energia) {
    return if ( modulosActivos > 5){energia * 0.2 * (-1)} else 0
  }

  override method esDePrestigioUniversal(){
    return self.estaCertificado() &&
            modulosActivos >3 &&
            self.todasLasTecnologiasActivas()

  }

}

class Eterico inherits Equipo{
    const fluctuacion
    const portales 

    override method esDePrestigioUniversal(){
        return fluctuacion > 75 &&
                portales >= 2&&
                self.tecnologiasActivas() >= 2 
    }

    override method condicionAdicional(energia){
        return if(self.esDePrestigioUniversal()){energia * 1.15}else 0
    }


}

class Entrenador{
    const ciclosSolares
    var estaEnSintonia = false
    const precision
    var rol

    method precision() {
      return precision
    }
    method estaEnSintonia(){
        return estaEnSintonia
    }

    method initialize() {
        if(!precision.between(0, 100)) {
            self.error("la precision debe ser un valor entre 0 y 100")
        }
        if(!foz.roles().contains(rol)) {
            self.error("rol no valido")
        }
    }
    method cambiarRol(nuevoRol){
        if(foz.roles().contains(nuevoRol)){rol = nuevoRol}
        else { self.error("rol no valido")}
    }

    method esEliteGalactica(){
        return ciclosSolares >10 && rol.condicion(self)
    }
}

object foz {
    const property roles = [estratega,arquitecto,guia]
}

object estratega {

    method condicion(unEntrenador){
        return unEntrenador.precision() > 80
    }
  
}

object arquitecto {
  method condicion(unEntrenador){
    return unEntrenador.estaEnSintonia()
  }
}

object guia {
  method condicion(unEntrenador){
    return true
  }
}

class Tecnologia {
    const nombre
    const valorEnergetico
    var activa
    method activa() = activa
    method valorEnergetico() = valorEnergetico
    method activar() {activa=true}
    method desactivar() {activa=false}
    

}