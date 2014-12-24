// Playground - noun: a place where people can play

import UIKit


// shopping list (strings)

let myConstantString = "iPhone"
var myVariableString = "iPad"

var shoppingList = "I need to buy an " +
	myConstantString + " and an " + myVariableString

shoppingList += ", and maybe an Apple TV"

var shoppingListCountString = "This list has \(1 + 1 + 1) items"

// music genres (arrays)

var musicGenres = ["Pop", "Rock", "Jazz", "Hip-hop", "Classical"]

let pop = musicGenres[0]let popRock = musicGenres[0..<2]let popRockJazz = musicGenres [0...2]

musicGenres.append(J-Pop")
musicGenres[1] = "Rock and Roll"

var musicGenres2 : Array<Any> = ["Pop", "Rock", "Jazz", "Hip-hop", "Classical"]
musicGenres2.append(2.99)

// planetary mass (dictionaries)

var planetaryMass = [
	"Mercury"	: 3.301E+23,
	"Venus"		: 4.867E+24,
	"Earth"		: 5.972E+24,
	"Mars"		: 6.417E+23,
	"Jupiter"	: 1.899E+27,
	"Saturn"	: 5.685E+26,
	"Uranus"	: 8.682E+25,
	"Neptune"	: 1.024E+26,
]

planetaryMass["Pluto"] = 1.471E+22

planetaryMass // click the "eye" icon and notice that pluto is now in the dictionary

// this won't work because you could get nil
// println ("Earth's mass is \(planetaryMass["Earth"]) kg")

// optionals
// prints "Earth's mass is Optional(5.972e+24) kg"
let mass : Double? = planetaryMass["Earth"]
if mass != nil {
	println ("Earth's mass is \(mass) kg")
} else {
	println ("No such planet")
}

// prints "Earth's mass is 5.972e+24 kg"
if let unwrappedMass : Double = planetaryMass["Earth"] {
	println ("Earth's mass is \(unwrappedMass) kg")
} else {
	println ("No such planet")
}

// first line of above could also be written:
// if let unwrappedMass = planetaryMass["Earth"] as? Double {



// prints "Earth's mass is 5.972e+24 kg"
let optionalMass : Double? = planetaryMass["Gallifrey"]
if optionalMass != nil {
	println ("Earth's mass is \(optionalMass!) kg")
} else {
	println ("No such planet")
	// don't do this, it crashes
	//println ("Failed to get planet's mass: \(optionalMass!)")
}


