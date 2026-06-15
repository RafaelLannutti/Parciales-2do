class Equipo {
    const nombre
    const energiaBase
    const entrenador
    const tecnologias = []

    method energiaTotal() {
        const subtotal = energiaBase + self.valorEnergiaTecnologiasActivas()
        return subtotal + self.valorAdicional(subtotal)
    }  
    method agregarTecnologia(unaTecnologia) {
        tecnologias.add(unaTecnologia)
    }
    method tecnologiasActivas() = tecnologias.filter({t=>t.activa()})
    method valorEnergiaTecnologiasActivas() = 
            self.tecnologiasActivas().sum({t=>t.valorEnergetico()})

    method valorAdicional(energia)
    method esDePrestigioUniversal()
    method todasLasTecnologiasActivas() = tecnologias.all({t=>t.activa()})
    method cantidadTecnologiasActivas() = tecnologias.count({t=>t.activa()})
}


class Luminico inherits Equipo {
    const radiacion
    const cristales = []
    override method valorAdicional(subtotalEnergia) {
        return if(radiacion<=5000) subtotalEnergia * 0.1 else 0
    }
    override method esDePrestigioUniversal() {
        return cristales.size() >= 3
        && entrenador.esEliteGalactico()
        && !self.tecnologiasActivas().isEmpty()
    }
}

class Sintetico inherits Equipo {
    const procesamiento
    const modulosActivos
    var certificado = false

    method certificar() {certificado=true}
    override method valorAdicional(subtotalEnergia) {
        return if(modulosActivos>5) subtotalEnergia * 0.2 * (-1) else 0
    }
    override method esDePrestigioUniversal() {
        return certificado
        && modulosActivos > 3
        && self.todasLasTecnologiasActivas()
    }
}

class Eterico inherits Equipo {
    const fluctuacion
    const portales

    override method esDePrestigioUniversal() {
        return fluctuacion > 75
        && portales >= 2
        && self.cantidadTecnologiasActivas() >= 2
    }

    override method valorAdicional(subtotalEnergia) {
        return if(self.esDePrestigioUniversal()) subtotalEnergia * 0.15 else 0
    }
}

class Entrenador {
    const ciclosSolares
    var estaEnSintonia = false
    const precision
    var rol

    method estaEnSintonia() = estaEnSintonia
    method precision() = precision
    method yaEstaEnSintonia() {estaEnSintonia=true}
    method sePudrioConElEquipo() {estaEnSintonia=false}

    method initialize() {
        if(!precision.between(0, 100)) {
            self.error("la precision debe ser un valor entre 0 y 100")
        }
        if(!foz.roles().contains(rol)) {
            self.error("rol no valido")
        }
    }

    method cambiarRol(nuevoRol) {
        if(!foz.roles().contains(nuevoRol)) {
            self.error("rol no valido")
        }
        rol = nuevoRol
    }

    method esEliteGalactico() {
        return ciclosSolares > 10 && rol.condicionPorRol(self)
    }
}

object estratega {
  method condicionPorRol(unEntrenador) {
    return unEntrenador.precision() > 80
  }
}

object arquitecto {
    method condicionPorRol(unEntrenador) {
        return unEntrenador.estaEnSintonia()
    }
}

object guia {
    method condicionPorRol(unEntrenador) {return true}
}

object foz {
    const property roles = [estratega,arquitecto,guia]
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