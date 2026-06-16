object ciudadFuturista{
    var  property cantidadMaximadeDrones = 10
}

class Dron{
    var  autonomia
    const nivelDeProcesamiento
    var mision

    method mision()= mision
    method cambiarMision(nuevaMision){mision= nuevaMision}
    method eficienciaOperativa() = autonomia * 10 + mision.obtenerExtra()
    method esAvanzadoSegunTipo()
    method esAvanzado() = self.esAvanzadoSegunTipo() || mision.esAvanzadaEnMision(self)
    method reducirAutonomiaEn() {autonomia = autonomia * 0.95}
    method autonomia()= autonomia

}

class DronComercial inherits Dron{
    override method eficienciaOperativa() = super() * 1.1
    override method esAvanzadoSegunTipo() = false

}

class DronDeSeguridad inherits Dron{
    override method esAvanzadoSegunTipo() = nivelDeProcesamiento >50

}


object transporte {

    method obtenerExtra() = 10
    method esAvanzadaEnMision(unDron) = unDron.autonomia() >50
    

}

object exploracion {
    method obtenerExtra() = 0
    method esAvanzadaEnMision(unDron) = unDron.eficienciaOperativa().even()

}

class Vigilancia {
    const sensores = []

    method obtenerExtra()= sensores.sum ({s => s.eficiencia()})
    method esAvanzadaEnMision(unDron) = sensores.all({s => s.esDuradero()})

}

class Sensor {
    const capacidad
    const durabilidad
    const tieneMejoras

    method eficiencia() = if (tieneMejoras) capacidad *2 else capacidad
    method esDuradero() = durabilidad > capacidad * 2




}

class Escuadron {
    const drones = []

    method agregarDron(unDron){
        if (drones.size() >= ciudadFuturista.cantidadMaximadeDrones()){
            self.error("Supera la cantidad máxima definida por la ciudad")
        }
         drones.add(unDron)
    }

    method puedeOperarEn(unaZona) = self.tieneDronAvanzado() && 
                                    self.capacidadOperativa() > unaZona.tamanio() *1.5

    method tieneDronAvanzado() = drones.any({d => d.esAvanzado()})
    method capacidadOperativa() = drones.sum({d => d.eficienciaOperativa()})
    method reducirAutonomiaEscuadron() =drones.forEach({ d => d.reducirAutonomiaEn()})
    method operarSobre(unaZona) {
        if (self.puedeOperarEn(unaZona)){
            unaZona.recibirOperacion()
            self.reducirAutonomiaEscuadron()
        }
    }

}

class Zona {
    const tamanio
    var operacionesRecibidas = 0

    method tamanio()=tamanio
    method recibirOperacion(){
        operacionesRecibidas +=1
    }
}