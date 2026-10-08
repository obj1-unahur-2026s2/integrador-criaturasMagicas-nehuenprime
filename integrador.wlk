class Criatura{
    var poderMagico
    method poderMagico()
    method astucia()
    method rolEnElParque()
    method poderOfensivo() = self.poderMagico() * 10 + self.rolEnElParque().poderExtra()
    method esFormidable()
    method esExtraordinaria() = self.rolEnElParque().esExtraordinario(self)
    method perderPoderMagico(){
        poderMagico = poderMagico * 0.85
    } 
}

class Duende inherits Criatura{
    override method rolEnElParque() = guardian

    override method poderOfensivo() {
        return super() + super() * 0.1
    }
    method esAstuta() = false
}

class Hada inherits Criatura{
    var kilometros = 2

    method cuantosKilometros() = kilometros
    method aumentarCantidad(cantKilometros) {
        kilometros = (kilometros + cantKilometros).min(25)
    }
    method esAstuta() = self.astucia() > 50
    override method esExtraordinaria() = super() && self.cuantosKilometros() > 10
}


class Rol {
    method poderExtra()
    method esExtraordinario(criatura)
}

object guardian inherits Rol{
    override method poderExtra() = 100
    override method esExtraordinario(criatura) = criatura.poderMagico() > 50 
}

object hechizero inherits Rol{
    override method poderExtra() = 0
    override method esExtraordinario(criatura) = true
}

object domador inherits Rol{
    const mascotas = []

    override method poderExtra(){
        (mascotas.filter({mascota => mascota.tieneCuernos()}).size()) * 150
    }
    method agregarMascota(mascota) {
        mascotas.add(mascota)
    }
    override method esExtraordinario(criatura) = (criatura.poderMagico() >= 15) && mascotas.all({mascota => mascota.esVeterana()})
}
class Mascota {
    var edad
    const tieneCuernos

    method tieneCuernos() = tieneCuernos
    method edad() = edad
    method cumplirAnio(){
        edad += 1
    } 
    method esVeterana() = edad >= 10
}


class Colonia {
    const criaturas = []

    method poderOfensivo() = criaturas.sum({criatura => criatura.poderOfensivo()}) 
    method agregar(criatura){
        criaturas.add(criatura)
    }
    method sacar(criatura){
        criaturas.remove(criatura)
    } 
    method cantidadDeFormidables() = criaturas.filter({ criatura => criatura.esFormidable()}).size()
    method conquistar(area) {
        if(self.poderOfensivo() > area.poderDefensivo()){
            area.cambiarColonia(self)
        }else{
            criaturas.forEach({ criatura => criatura.perderPoderMagico()})
        }
    }
}

class Area {
    var colonia
    method poderDefensivo()
    method cambiarColonia(nuevaColonia) {
        colonia = nuevaColonia
    }
}

class Claro inherits Area{
    override method poderDefensivo() {
        colonia.poderOfensivo() + 100
    }
}

class Castillo inherits Area {
    override method poderDefensivo() = colonia.cantidadDeFormidables() * 200
}
