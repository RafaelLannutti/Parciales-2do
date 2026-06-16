
object ciudadFuturista {
    var property maximaCantidadDrones = 10
}



class Dron {
    var autonomia
    const nivelProcesamiento
    var mision 

    method autonomia() = autonomia
    method nivelProcesamiento() = nivelProcesamiento
    method mision() = mision
    method mision(nuevaMision) { mision = nuevaMision }

   
    method eficienciaOperativa() = autonomia * 10 + mision.extra(self)

   
    method esAvanzado() = self.esAvanzadoPorTipo() || mision.esAvanzada(self)

   
    method esAvanzadoPorTipo()

   
    method reducirAutonomia() {
        autonomia = autonomia * 0.95
    }
}



class DronComercial inherits Dron {
   
    override method eficienciaOperativa() = super() * 1.10

    
    override method esAvanzadoPorTipo() = false
}

class DronDeSeguridad inherits Dron {
   
    override method esAvanzadoPorTipo() = nivelProcesamiento > 50


}



object transporte {
    method extra(dron) = 100
    method esAvanzada(dron) = dron.autonomia() > 50
}

object exploracion {
    method extra(dron) = 0
    method esAvanzada(dron) = dron.eficienciaOperativa().truncate(0) % 2 == 0
}

class Vigilancia {
    const sensores = []

    method extra(dron) = sensores.sum({ sensor => sensor.eficiencia() })
    
    method esAvanzada(dron) = sensores.all({ sensor => sensor.esDuradero() })
}





class Sensor {
    const capacidad
    const durabilidad
    const tieneMejoras

  
    method eficiencia() = if (tieneMejoras) capacidad * 2 else capacidad
    
   
    method esDuradero() = durabilidad > capacidad * 2
}

class Zona {
    const tamano
    var operacionesRecibidas = 0

    method tamano() = tamano
    method operacionesRecibidas() = operacionesRecibidas

    method recibirOperacion() {
        operacionesRecibidas += 1
    }
}

class Escuadron {
    const drones = []


    method agregarDron(dron) {
        if (drones.size() >= ciudadFuturista.maximaCantidadDrones()) {
            self.error("Supera la cantidad máxima definida por la ciudad")
        }
        drones.add(dron)
    }

    method capacidadOperativa() = drones.sum({ d => d.eficienciaOperativa() })

    method tieneDronAvanzado() = drones.any({ d => d.esAvanzado() })

    method puedeOperar(zona) = self.tieneDronAvanzado() && self.capacidadOperativa() > zona.tamano() * 1.5

  
    method operar(zona) {
        if (self.puedeOperar(zona)) {
            zona.recibirOperacion()
            drones.forEach({ d => d.reducirAutonomia() })
        }
    }
}

