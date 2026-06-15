import plagas.*
class Hogar{
    var mugre
    const confort

    method esBueno(){
        return mugre * 2 <= confort
    }

    method recibirAtaqueDe(unaPlaga){
        mugre = mugre + unaPlaga.nivelDeDanio()
    }
}

class Huerta{
    var produccion

    method esBueno(){
        produccion >nivelDeCosechas.valor()
    }

    method recibirAtaqueDe(unaPlaga){
        produccion = produccion - (
            unaPlaga.nivelDeDanio() * 0.1
            + if(unaPlaga.transmiteEnfermedad())10 else 0)
    }
}

object nivelDeCosechas {
    var property valor = 10
}

class Mascota {
    var salud
    method esBueno(){
        salud > 250
    }
    method recibirAtaqueDe(unaPlaga){
        if(unaPlaga.transmiteEnfermedad()){ salud = (salud - unaPlaga.nivelDeDanio()).max(0)}
    }
}

class Barrio {
    const property elementos = []

    method esCopado(){
        return self.cantElementosBuenos() > elementos.size() / 2
    }
    method cantElementosBuenos(){ 
        return elementos.count({e => e.esBueno()})
    }
}


