class Planta{
  const anioDeObtension
  var property altura
method horasDeSolQueTolera()
  method esFuerte()=self.horasDeSolQueTolera()>10
 method daNuevasSemillas()=self.esFuerte() or self.condicion()
 method condicion()


}
class Menta inherits Planta{
override method horasDeSolQueTolera()=6
override method condicion()=altura>0.4
method espacioQueOcupa()=altura*3

method leResultaIdeal(unaParcela){
  return unaParcela.superficie()>6
}
 

}
class Soja inherits Planta{
override method horasDeSolQueTolera(){
 return
    if (altura < 0.5) {
        return 6
    } else if (altura.between(0.5,1)) {
        return 7
    } else {
        return 9
    }

}
override method condicion(){
  return anioDeObtension>2007 and altura>1
}
method espacioQueOcupa(){
  return altura*0.5
}
method leResultaIdeal(unaParcela){
  return unaParcela.horasDeSolAlDia()==self.horasDeSolQueTolera()
}


 

}
class Quinoa inherits Planta{
const horasDeSolQueTolera
override method horasDeSolQueTolera()=horasDeSolQueTolera
method espacioQueOcupa(){
  return 0.5
}
override method condicion(){
  return anioDeObtension<2005
}
method leResultaIdeal(unaParcela){
  return !unaParcela.plantas().any({p=>p.altura()>1.5})
}

}
class SojaTransgenica inherits Soja{
  override method daNuevasSemillas()=false
  override method leResultaIdeal(unaParcela){
  return unaParcela.cantidadDePlantasQueTolera()==1
}
}
class HierbaBuena inherits Menta{
  override method espacioQueOcupa()=super()*2 
}
class Parcela{
  var ancho
  var largo
  const property horasDeSolAlDia
  const property plantas=[]
  method superficie()=ancho*largo
  method cantidadDePlantasQueTolera(){
    return
      if(ancho>largo){
        self.superficie()/5
      }
      else{
        self.superficie()/3+largo
      }
    
  }
  method seAsociaBien(unaPlanta)
  method cantidadQueSeAsocianBien(){
    return plantas.count({p=>self.seAsociaBien(p)})
  }
  method porcentajePlantasBienAsociadas(){
    return self.cantidadQueSeAsocianBien()*100/plantas.size()
  }
  method tieneComplicaciones(){
    return plantas.any({p=>p.horasDeSolQueTolera()<horasDeSolAlDia})
  }
  method plantarUnaPlanta(unaPlanta){
    if(!self.hayEspacioParaPlantar() or horasDeSolAlDia-unaPlanta.horasDeSolQueTolera()>=2)self.error("cantidad maxima de plantas alcanzada")
    plantas.add(unaPlanta)

  }
  method hayEspacioParaPlantar(){
    return plantas.size()<self.cantidadDePlantasQueTolera()
  }
  
}
class Ecologica inherits Parcela{
override method seAsociaBien(unaPlanta){
  return !self.tieneComplicaciones() and unaPlanta.leResultaIdeal(self)}
  }
class Industrial inherits Parcela{
 override  method seAsociaBien(unaPlanta){
  return plantas.size()<=2 and unaPlanta.esFuerte()}
  }
object inta{
const parcelas=[]
method agregarParcela(unaParcela){
  parcelas.add(unaParcela)
}
method promedioDePlantasPorParcela(){
return parcelas.sum({p=>p.plantas().size()}) / parcelas.size()
}
method parcelaMasAutosustentable(){
  return self.parcerlasConMasDeCuatroPlantas().max({p=>p.porcentajePlantasBienAsociadas()})
}
method parcerlasConMasDeCuatroPlantas(){
  return parcelas.filter({p=>p.plantas().size()>4})}
  }
  