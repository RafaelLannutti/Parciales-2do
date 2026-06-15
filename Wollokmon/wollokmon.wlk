class Wolomon{
    var nivelExperiencia
    var salud = 200
    const ataques = []

    method salud() = salud

    method nivelExperiencia(){
        return nivelExperiencia
    }

    method puedeAtacar() = self.salud() > 10

    method aprenderAtaque(unAtaque) {
        ataques.add(unAtaque)
    } 

    method mejorAtaque()  {
        return ataques.max({a => a.daño()})
    }



    method recibirAtaque(unAtacante){
        salud = salud - unAtacante.dañoEfectuado().max(0)
        self.efectoPostCombate()
    }

    method efectoPostCombate

    method usarPocion() {
       salud += 20
    }
    


}

class Ataque {
    var daño
    method daño(){
        return daño
    } 
}

class Bicho inherits Wolomon{
    method dañoEfectuado(){
        ataques.sum({a => a.daño() })
    }

    override method efectoPostCombate() {
      nivelExperiencia += 10
    }
}

class Dragon inherits Wolomon {
    var fuegoInterior
    override method puedeAtacar() {
      return super() && fuegoInterior > 20 
    }
    method fuegoInterior() {
      return fuegoInterior
    }

    method dañoEfectuado(){
        return self.mejorAtaque() + fuegoInterior
    }

    override method efectoPostCombate() {
      nivelExperiencia = nivelExperiencia + fuegoInterior/2
    }    
}

class Electrico inherits Wolomon {

    method estaCargado(){
        return clima.humedad() > 97
    }


    override method puedeAtacar() {
      return super() && self.estaCargado ()
    }

    method DañoEfectuado() {
      if (self.estaCargado()){ ataques.first().daño()}
        else{return 0}
    }

    override method efectoPostCombate(){
        nivelExperiencia -= 1
        if (self.estaCargado()){ nivelExperiencia += 20 }
    }


}   
object clima {
    var property humedad = true    
}

class Legendario inherits Dragon{
    const insignia
    override method dañoEfectuado(){  
        return super() + insignia.potenciadorPara(self) 
     }

}

object insigniaRoja{
    method potenciadorPara(unDragon) = if (unDragon.fuegoInterior()>20) 10 else 0
}
object insigniaAzul{
    method potenciadorPara(unDragon) = 8
}
object insigniaVerde{
    method potenciadorPara(unDragon) = 0
}

class Torneo {
    var grupo
    method aprenderAtaqueMasivo (unAtaque){
        grupo.forEach({g=> g.aprenderAtaque(unAtaque)})
    }

    method contieneA(wollokmon){
        return grupo.contains(wollokmon)
    }

    method batallar(w1,w2) { // el wollok1 ataca al wollok 2
      if (self.contieneA(w1)&& self.contieneA(w2)){
        w2.recibirAtaque(w1)
      }else {self.error("Hay un wollokmon que no esta inscripto al torneo")}
    }

    method batallarAutomaticamente(){
        return self.mayorPS().recibirAtaque(self.mayorNivel())
    }

    method mayorPS() {
      return grupo.max({g => g.salud()})
    }
    method mayorNivel() {
      return grupo.max({g => g.nivelExperiencia()})
    }

    method darPocion(){
        grupo.foreach({g => g.usarPocion()})
    }
    
}