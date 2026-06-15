class ArmaDeFilo{
    const filo
    const longitud
    
    method ataque() {
       return filo * longitud
    }
}

class ArmaContundete{
    const peso

    method ataque() {
       return peso
    }
}

object casco {
    method defensa(luchador){
        return 10
    }
}

object escudo{
    method proteccion(luchador) {
      return 5 + luchador.destreza() *0.1
    }
}

class Gladiador{
    var vida = 100
    method defensa ()
    method fuerza ()
    method destreza ()

    method vida() {
      return vida
    }

    method atacar(unGladiador) {
      unGladiador.recibirAtaque()
    }
    method recibirAtaque(unGladiador) {
      vida = vida - (unGladiador.poderDeAtaque() - self.defensa())
    }

    method pelearCon(unGladiador){
        self.atacar(unGladiador)
        unGladiador.defensa(self)
    }

    method curar(){
        vida = 100
    }
}

class Mirmillon inherits Gladiador {
    var arma
    var armadura
    var fuerza

    method cambiarArma(unArma) {
      arma = unArma
    }
    method cambiarArmadura(unaArmadura) {
      armadura = unaArmadura
    }

    override method fuerza() {
      return fuerza
    }

    method cambiarFuerza(valor){
        fuerza = valor
    }

    override method destreza() {
      return 15
    }

    method poderDeAtaque() {
        return fuerza + arma.ataque()
    }

    override method defensa() {
      return armadura.proteccion(self) + self.destreza()
    }

    method formarGrupoCon(unGladiador){
        new Grupo(
            nombre ="Mirmillolandia",
            miembros= #{self,unGladiador})
    }
    
}

class Dimachaerus inherits Gladiador{
    const armas = []
    var destreza

    method agregarArma(unArma){
        armas.add(unArma)
    }
    method quita(unArma){
        armas.remove(unArma)
    }

    override method fuerza(){
        return 10
    }
    override method destreza(){
        return destreza
    }

    method poderDeAtaque(){
        return armas.sum({a => a.ataque()}) + self.fuerza()
    }
    
    override method atacar (unGladiador){
        super(unGladiador)
        destreza += 1
    }
    override method defensa(){
        return destreza / 2
    }
    method formarGrupoCon(unGladiador){
        new Grupo(
            nombre ="D-" + (self.poderDeAtaque() + unGladiador.poderDeAtaque()).toString(),
            miembros= #{self,unGladiador})
    }

}

class Grupo{
    const miembros = #{}
    var cantPeleas = 0
    const property nombre  

    method agregar(unGladiador) {
      miembros.add(unGladiador)
    }
    method quitar(unGladiador){
        miembros.remove(unGladiador)
    }

    method puedeCombair(){
       return miembros.filter({m => m.vida() > 0 })
    }

    method campeon() {
      return self.puedeCombair().max({ m => m.ataque()})
    }

    method combatirCon(unGrupo) {
      self.campeon().pelearCon(unGrupo.campeon())
      self.campeon().pelearCon(unGrupo.campeon())
      self.campeon().pelearCon(unGrupo.campeon())
      cantPeleas +=3
    }
}

object coliseo {
    method organizarCombate(unGrupo,otroGrupo){
        unGrupo.combatirCon(otroGrupo)
    }
    method organizarCombateContraGladiador(unGrupo,unGladiador) {
      unGrupo.forEach({g => g.pelearCon(unGladiador)})
    }
    method curar(unGladiador) {
      unGladiador.curar(unGladiador)
    }
    method curarGrupo(unGrupo) {
      unGrupo.forEach({g =>g.curar()})
    }
}
