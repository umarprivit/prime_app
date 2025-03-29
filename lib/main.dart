import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/apptheme.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/screens/starting_screens/splash_screen.dart';
import 'package:prime_app/service/firestore_service.dart';
import 'package:prime_app/service/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefService.init();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  FirebaseMessaging.instance.subscribeToTopic("all");
  String? deviceId = await SharedPrefService().getDeviceId();
  print(deviceId);
  if (!(deviceId!.isEmpty)) {
    print(
        "Trying to delete expire courses registerd on this device with device id $deviceId");
    await FirestoreService().isExpired(deviceId: deviceId);
  }

  runApp(GetMaterialApp(
    theme: AppTheme.lightTheme,
    getPages: AppRoutes.routes,
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseMessaging.instance.subscribeToTopic("all");
  print('background message ${message.notification!.title}');
}

// Map<int, List<Map<String, dynamic>>> mcqsByPage = {
//   1: [
//     {
//       "question": "What is the SI unit of force?",
//       "options": ["Newton", "Joule", "Watt", "Pascal"],
//       "answer": "Newton"
//     },
//     {
//       "question": "The energy stored in an object due to its motion is called:",
//       "options": ["Potential energy", "Kinetic energy", "Thermal energy", "Chemical energy"],
//       "answer": "Kinetic energy"
//     },
//     {
//       "question": "The law of conservation of energy states that:",
//       "options": [
//         "Energy can be created or destroyed",
//         "Energy can only be destroyed",
//         "Energy can neither be created nor destroyed",
//         "Energy is always constant"
//       ],
//       "answer": "Energy can neither be created nor destroyed"
//     },
//     {
//       "question": "What is the SI unit of work?",
//       "options": ["Watt", "Newton", "Joule", "Meter"],
//       "answer": "Joule"
//     },
//     {
//       "question": "Which of the following is a vector quantity?",
//       "options": ["Speed", "Distance", "Acceleration", "Mass"],
//       "answer": "Acceleration"
//     },
//     {
//       "question": "The rate of change of velocity is called:",
//       "options": ["Force", "Acceleration", "Speed", "Momentum"],
//       "answer": "Acceleration"
//     },
//     {
//       "question": "What is the SI unit of power?",
//       "options": ["Watt", "Joule", "Newton", "Ampere"],
//       "answer": "Watt"
//     },
//     {
//       "question": "The force required to move a body with constant velocity is equal to:",
//       "options": [
//         "The weight of the body",
//         "The frictional force",
//         "The normal force",
//         "Zero"
//       ],
//       "answer": "The frictional force"
//     },
//     {
//       "question": "Which of the following quantities is a scalar?",
//       "options": ["Displacement", "Velocity", "Speed", "Force"],
//       "answer": "Speed"
//     },
//     {
//       "question": "A body is said to be in equilibrium when:",
//       "options": [
//         "The net force acting on it is zero",
//         "The net torque acting on it is zero",
//         "Both A and B",
//         "The velocity is zero"
//       ],
//       "answer": "Both A and B"
//     },
//     {
//       "question": "What is the SI unit of electric current?",
//       "options": ["Ampere", "Volt", "Coulomb", "Ohm"],
//       "answer": "Ampere"
//     },
//     {
//       "question": "The resistance of a conductor depends on:",
//       "options": [
//         "Its temperature",
//         "Its material",
//         "Its length and cross-sectional area",
//         "All of the above"
//       ],
//       "answer": "All of the above"
//     },
//     {
//       "question": "Ohm's law states that:",
//       "options": [
//         "Current is inversely proportional to voltage",
//         "Voltage is proportional to current",
//         "Current is directly proportional to voltage and inversely proportional to resistance",
//         "Resistance is inversely proportional to current"
//       ],
//       "answer": "Current is directly proportional to voltage and inversely proportional to resistance"
//     },
//     {
//       "question": "What is the SI unit of voltage?",
//       "options": ["Ampere", "Ohm", "Volt", "Watt"],
//       "answer": "Volt"
//     },
//     {
//       "question": "Which of the following is a non-renewable energy source?",
//       "options": ["Solar energy", "Wind energy", "Coal", "Hydroelectric power"],
//       "answer": "Coal"
//     },
//     {
//       "question": "What does a convex lens do to parallel rays of light?",
//       "options": [
//         "Diverges them",
//         "Focuses them to a point",
//         "Reflects them",
//         "Absorbs them"
//       ],
//       "answer": "Focuses them to a point"
//     },
//     {
//       "question": "The speed of light in vacuum is approximately:",
//       "options": ["3 × 10^8 m/s", "3 × 10^6 m/s", "1 × 10^8 m/s", "2 × 10^8 m/s"],
//       "answer": "3 × 10^8 m/s"
//     },
//     {
//       "question": "The frequency of a wave is:",
//       "options": [
//         "The number of complete cycles passing a point in one second",
//         "The distance between two successive crests",
//         "The speed of the wave",
//         "The amplitude of the wave"
//       ],
//       "answer": "The number of complete cycles passing a point in one second"
//     },
//     {
//       "question": "Which of the following waves does not require a medium for propagation?",
//       "options": ["Sound wave", "Light wave", "Water wave", "Seismic wave"],
//       "answer": "Light wave"
//     },
//     {
//       "question": "Which of the following is an example of a non-contact force?",
//       "options": ["Tension", "Friction", "Gravitational force", "Normal force"],
//       "answer": "Gravitational force"
//     }
//   ],
//   2: [
//     {
//       "question": "What is the center of gravity?",
//       "options": [
//         "The point where the mass of a body is concentrated",
//         "The point where all the forces acting on a body are balanced",
//         "The point where gravitational force acts",
//         "The point where the object has no weight"
//       ],
//       "answer": "The point where the mass of a body is concentrated"
//     },
//     {
//       "question": "The unit of frequency is:",
//       "options": ["Second", "Hertz", "Meter", "Decibel"],
//       "answer": "Hertz"
//     },
//     {
//       "question": "The principle of moments states that:",
//       "options": [
//         "The sum of moments about a point is equal to zero in equilibrium",
//         "The moment is equal to the force applied times the distance",
//         "The sum of forces in any direction is equal to zero",
//         "All of the above"
//       ],
//       "answer": "All of the above"
//     },
//     {
//       "question": "In a closed circuit, the current is:",
//       "options": [
//         "Inversely proportional to the resistance",
//         "Directly proportional to the voltage",
//         "Directly proportional to the resistance",
//         "Inversely proportional to the voltage"
//       ],
//       "answer": "Directly proportional to the voltage"
//     },
//     {
//       "question": "The acceleration due to gravity on Earth is approximately:",
//       "options": ["10 m/s²", "9.8 m/s²", "12 m/s²", "5 m/s²"],
//       "answer": "9.8 m/s²"
//     },
//     {
//       "question": "The mechanical advantage of a simple machine is the ratio of:",
//       "options": [
//         "Output force to input force",
//         "Input force to output force",
//         "Distance moved by input force to distance moved by output force",
//         "None of the above"
//       ],
//       "answer": "Output force to input force"
//     },
//     {
//       "question": "The energy possessed by an object due to its position is called:",
//       "options": ["Kinetic energy", "Potential energy", "Thermal energy", "Chemical energy"],
//       "answer": "Potential energy"
//     },
//     {
//       "question": "A circuit with resistors connected in parallel has:",
//       "options": [
//         "The same current through all resistors",
//         "The same voltage across all resistors",
//         "A total resistance greater than the smallest resistor",
//         "None of the above"
//       ],
//       "answer": "The same voltage across all resistors"
//     },
//     {
//       "question": "The change in momentum of an object is equal to:",
//       "options": [
//         "The net force applied multiplied by time",
//         "The mass of the object multiplied by acceleration",
//         "The product of mass and velocity",
//         "The work done on the object"
//       ],
//       "answer": "The net force applied multiplied by time"
//     },
//     {
//       "question": "What is the unit of pressure?",
//       "options": ["Newton", "Pascal", "Joule", "Watt"],
//       "answer": "Pascal"
//     },
//     {
//       "question": "The formula for kinetic energy is:",
//       "options": [
//         "KE = ½mv²",
//         "KE = mv²",
//         "KE = mgh",
//         "KE = ½mgh"
//       ],
//       "answer": "KE = ½mv²"
//     },
//     {
//       "question": "Which of the following is an example of a scalar quantity?",
//       "options": ["Displacement", "Force", "Mass", "Velocity"],
//       "answer": "Mass"
//     },
//     {
//       "question": "The force of attraction between two point masses is directly proportional to:",
//       "options": [
//         "The product of the masses",
//         "The distance between the masses",
//         "The square of the distance between the masses",
//         "The velocity of the masses"
//       ],
//       "answer": "The product of the masses"
//     },
//     {
//       "question": "A car accelerates from rest to 20 m/s in 10 seconds. What is its acceleration?",
//       "options": ["2 m/s²", "1 m/s²", "4 m/s²", "5 m/s²"],
//       "answer": "2 m/s²"
//     },
//     {
//       "question": "The speed of sound in air is approximately:",
//       "options": ["330 m/s", "500 m/s", "340 m/s", "1500 m/s"],
//       "answer": "340 m/s"
//     },
//     {
//       "question": "What is the frequency of a wave with a wavelength of 2 meters and a speed of 6 m/s?",
//       "options": ["3 Hz", "2 Hz", "4 Hz", "6 Hz"],
//       "answer": "3 Hz"
//     },
//     {
//       "question": "Which of the following phenomena occurs when light passes through a prism?",
//       "options": ["Reflection", "Refraction", "Diffraction", "Dispersion"],
//       "answer": "Dispersion"
//     },
//     {
//       "question": "A body in motion has:",
//       "options": [
//         "Only potential energy",
//         "Only kinetic energy",
//         "Both kinetic and potential energy",
//         "Neither kinetic nor potential energy"
//       ],
//       "answer": "Only kinetic energy"
//     },
//     {
//       "question": "The force required to stop a moving object is called:",
//       "options": ["Impulse", "Inertia", "Friction", "Momentum"],
//       "answer": "Impulse"
//     },
//     {
//       "question": "Which of the following is true for a projectile in motion?",
//       "options": [
//         "The horizontal velocity remains constant",
//         "The vertical velocity remains constant",
//         "The acceleration due to gravity is zero",
//         "Both horizontal and vertical velocities remain constant"
//       ],
//       "answer": "The horizontal velocity remains constant"
//     }
//   ],
//   3: [
//     {
//       "question": "The phenomenon of bending of light as it passes from one medium to another is called:",
//       "options": ["Reflection", "Refraction", "Diffraction", "Dispersion"],
//       "answer": "Refraction"
//     },
//     {
//       "question": "Which of the following is a unit of energy?",
//       "options": ["Watt", "Ampere", "Joule", "Ohm"],
//       "answer": "Joule"
//     },
//     {
//       "question": "The term \"work\" in physics refers to:",
//       "options": [
//         "A force applied over a distance",
//         "A force applied to an object",
//         "The energy possessed by an object",
//         "The energy required to move an object"
//       ],
//       "answer": "A force applied over a distance"
//     },
//     {
//       "question": "What does the law of universal gravitation state?",
//       "options": [
//         "Every mass attracts every other mass with a force proportional to the product of their masses",
//         "Objects fall with the same acceleration regardless of mass",
//         "The gravitational force is directly proportional to the square of the distance between two objects",
//         "Both A and B"
//       ],
//       "answer": "Every mass attracts every other mass with a force proportional to the product of their masses"
//     },
//     {
//       "question": "What is the formula for calculating the force acting on an object?",
//       "options": ["F = m × a", "F = m × v", "F = a × v", "F = m × g"],
//       "answer": "F = m × a"
//     },
//     {
//       "question": "In which type of wave do particles move parallel to the direction of wave propagation?",
//       "options": ["Longitudinal wave", "Transverse wave", "Electromagnetic wave", "Both A and B"],
//       "answer": "Longitudinal wave"
//     },
//     {
//       "question": "The image formed by a concave lens is:",
//       "options": [
//         "Real and inverted",
//         "Virtual and upright",
//         "Virtual and inverted",
//         "Real and upright"
//       ],
//       "answer": "Virtual and upright"
//     },
//     {
//       "question": "What is the resistance of a wire if the voltage is 10 V and the current is 2 A?",
//       "options": ["20 Ω", "5 Ω", "12 Ω", "10 Ω"],
//       "answer": "5 Ω"
//     },
//     {
//       "question": "Which of the following is not an example of energy transfer?",
//       "options": ["Work", "Heat", "Electric current", "Inertia"],
//       "answer": "Inertia"
//     },
//     {
//       "question": "The power dissipated in a resistor is given by:",
//       "options": ["P = IV", "P = V²/R", "P = I²R", "All of the above"],
//       "answer": "All of the above"
//     },
//     {
//       "question": "The phenomenon where light changes direction as it passes through a narrow opening is called:",
//       "options": ["Reflection", "Diffraction", "Refraction", "Dispersion"],
//       "answer": "Diffraction"
//     },
//     {
//       "question": "The pressure at a point in a liquid depends on:",
//       "options": [
//         "The volume of the liquid",
//         "The depth of the liquid",
//         "The temperature of the liquid",
//         "The density of the liquid"
//       ],
//       "answer": "The depth of the liquid"
//     },
//     {
//       "question": "The speed of a wave is determined by:",
//       "options": [
//         "The frequency and the amplitude",
//         "The wavelength and the frequency",
//         "The frequency and the temperature",
//         "The wavelength and the amplitude"
//       ],
//       "answer": "The wavelength and the frequency"
//     },
//     {
//       "question": "Which of the following is an example of a contact force?",
//       "options": ["Gravitational force", "Magnetic force", "Frictional force", "Electrical force"],
//       "answer": "Frictional force"
//     },
//     {
//       "question": "The energy of a photon is directly proportional to:",
//       "options": ["Its velocity", "Its frequency", "Its amplitude", "Its wavelength"],
//       "answer": "Its frequency"
//     },
//     {
//       "question": "What type of mirror is used in car headlights to focus light?",
//       "options": ["Concave mirror", "Convex mirror", "Plane mirror", "Parabolic mirror"],
//       "answer": "Concave mirror"
//     },
//     {
//       "question": "A wave with a higher frequency has:",
//       "options": [
//         "A longer wavelength",
//         "A shorter wavelength",
//         "The same wavelength",
//         "A higher speed"
//       ],
//       "answer": "A shorter wavelength"
//     },
//     {
//       "question": "The relationship between current, voltage, and resistance is given by:",
//       "options": ["Newton's law", "Coulomb's law", "Ohm's law", "Faraday's law"],
//       "answer": "Ohm's law"
//     },
//     {
//       "question": "Which of the following devices is used to measure electric current?",
//       "options": ["Ammeter", "Voltmeter", "Thermometer", "Barometer"],
//       "answer": "Ammeter"
//     },
//     {
//       "question": "What is the SI unit of frequency?",
//       "options": ["Meter", "Hertz", "Decibel", "Joule"],
//       "answer": "Hertz"
//     }
//   ],
//   4: [
//     {
//       "question": "In which of the following types of waves do the particles move perpendicular to the direction of wave propagation?",
//       "options": ["Longitudinal waves", "Transverse waves", "Electromagnetic waves", "Both B and C"],
//       "answer": "Transverse waves"
//     },
//     {
//       "question": "The energy required to raise the temperature of 1 kg of water by 1°C is called:",
//       "options": ["Joule", "Calorie", "Watt", "Ampere"],
//       "answer": "Calorie"
//     },
//     {
//       "question": "The distance between two consecutive crests or troughs of a wave is called:",
//       "options": ["Amplitude", "Frequency", "Wavelength", "Speed"],
//       "answer": "Wavelength"
//     },
//     {
//       "question": "Which of the following is a condition for an object to be in motion?",
//       "options": [
//         "It must be acted upon by an unbalanced force",
//         "It must be moving with constant velocity",
//         "It must be in equilibrium",
//         "It must be at rest"
//       ],
//       "answer": "It must be acted upon by an unbalanced force"
//     },
//     {
//       "question": "In a vacuum, all electromagnetic waves travel at:",
//       "options": ["3 × 10^8 m/s", "1 × 10^6 m/s", "3 × 10^6 m/s", "2 × 10^8 m/s"],
//       "answer": "3 × 10^8 m/s"
//     },
//     {
//       "question": "The unit of electrical resistance is:",
//       "options": ["Volt", "Ohm", "Ampere", "Watt"],
//       "answer": "Ohm"
//     },
//     {
//       "question": "What is the force exerted by a 10 kg object resting on the Earth's surface?",
//       "options": ["10 N", "100 N", "98 N", "1000 N"],
//       "answer": "98 N"
//     },
//     {
//       "question": "Which of the following is true for a longitudinal wave?",
//       "options": [
//         "The particles of the medium move in a direction perpendicular to the wave motion",
//         "The particles of the medium move parallel to the wave motion",
//         "Longitudinal waves do not carry energy",
//         "Longitudinal waves do not have a wavelength"
//       ],
//       "answer": "The particles of the medium move parallel to the wave motion"
//     },
//     {
//       "question": "The resistance of a conductor increases with:",
//       "options": [
//         "Decreasing temperature",
//         "Increasing length",
//         "Decreasing cross-sectional area",
//         "Both B and C"
//       ],
//       "answer": "Both B and C"
//     },
//     {
//       "question": "What is the principal focus of a convex lens?",
//       "options": [
//         "The point where parallel rays of light meet after passing through the lens",
//         "The point where parallel rays of light diverge after passing through the lens",
//         "The point where the lens is thicker",
//         "The point where the light enters the lens"
//       ],
//       "answer": "The point where parallel rays of light meet after passing through the lens"
//     },
//     {
//       "question": "In a sound wave, the region of compression has:",
//       "options": ["High density", "Low density", "No density", "Same density as the rest of the medium"],
//       "answer": "High density"
//     },
//     {
//       "question": "What is the force that resists the motion of an object through a fluid called?",
//       "options": ["Friction", "Tension", "Drag", "Buoyancy"],
//       "answer": "Drag"
//     },
//     {
//       "question": "The speed of a car moving at 72 km/h is equal to:",
//       "options": ["72 m/s", "20 m/s", "18 m/s", "10 m/s"],
//       "answer": "20 m/s"
//     },
//     {
//       "question": "The pressure exerted by a gas on the walls of its container is caused by:",
//       "options": [
//         "The force of gravity",
//         "The motion of molecules colliding with the container walls",
//         "The temperature of the gas",
//         "The volume of the gas"
//       ],
//       "answer": "The motion of molecules colliding with the container walls"
//     },
//     {
//       "question": "Which of the following does not change the acceleration due to gravity?",
//       "options": [
//         "Height above the Earth's surface",
//         "Latitude",
//         "Mass of the object",
//         "Altitude"
//       ],
//       "answer": "Mass of the object"
//     },
//     {
//       "question": "The magnetic field around a current-carrying conductor is:",
//       "options": [
//         "Stronger farther from the conductor",
//         "Weakest at the center of the conductor",
//         "Stronger the closer you get to the conductor",
//         "Nonexistent"
//       ],
//       "answer": "Stronger the closer you get to the conductor"
//     },
//     {
//       "question": "The motion of a satellite in orbit is due to the balance between:",
//       "options": [
//         "Its velocity and the gravitational pull of the Earth",
//         "The satellite's weight and the gravitational pull of the Earth",
//         "The centrifugal force and the centripetal force",
//         "Both A and C"
//       ],
//       "answer": "Both A and C"
//     },
//     {
//       "question": "Which of the following is true about the specific heat capacity of water?",
//       "options": [
//         "It is very low",
//         "It is very high",
//         "It is equal to the specific heat capacity of air",
//         "It is zero"
//       ],
//       "answer": "It is very high"
//     },
//     {
//       "question": "The color of an object is determined by:",
//       "options": [
//         "The wavelength of light it emits",
//         "The wavelength of light it absorbs",
//         "The temperature of the object",
//         "Both A and B"
//       ],
//       "answer": "The wavelength of light it absorbs"
//     },
//     {
//       "question": "What happens when light enters a denser medium?",
//       "options": [
//         "It bends away from the normal",
//         "It bends towards the normal",
//         "It is reflected",
//         "It passes straight through"
//       ],
//       "answer": "It bends towards the normal"
//     }
//   ],
//   5: [
//     {
//       "question": "The law of reflection states that:",
//       "options": [
//         "The angle of incidence is equal to the angle of refraction",
//         "The angle of incidence is equal to the angle of reflection",
//         "The angle of refraction is greater than the angle of incidence",
//         "The angle of incidence is smaller than the angle of reflection"
//       ],
//       "answer": "The angle of incidence is equal to the angle of reflection"
//     },
//     {
//       "question": "Which of the following is not a part of the electromagnetic spectrum?",
//       "options": ["Ultraviolet rays", "Radio waves", "Sound waves", "X-rays"],
//       "answer": "Sound waves"
//     },
//     {
//       "question": "A body is said to be in motion if:",
//       "options": [
//         "Its position is changing with respect to a reference point",
//         "It is accelerating",
//         "It is at rest",
//         "It is not affected by any force"
//       ],
//       "answer": "Its position is changing with respect to a reference point"
//     },
//     {
//       "question": "The energy of an object in motion is called:",
//       "options": ["Potential energy", "Kinetic energy", "Heat energy", "Internal energy"],
//       "answer": "Kinetic energy"
//     },
//     {
//       "question": "A wave with a larger amplitude has:",
//       "options": ["A higher frequency", "A lower frequency", "More energy", "Less energy"],
//       "answer": "More energy"
//     },
//     {
//       "question": "The velocity of a body is:",
//       "options": [
//         "Always constant",
//         "Always increasing",
//         "The rate of change of displacement",
//         "The rate of change of distance"
//       ],
//       "answer": "The rate of change of displacement"
//     },
//     {
//       "question": "What is the unit of electrical energy?",
//       "options": ["Volt", "Joule", "Watt", "Ohm"],
//       "answer": "Joule"
//     },
//     {
//       "question": "The process by which a solid turns directly into a gas is called:",
//       "options": ["Sublimation", "Condensation", "Evaporation", "Freezing"],
//       "answer": "Sublimation"
//     },
//     {
//       "question": "The rate of change of velocity is:",
//       "options": ["Acceleration", "Speed", "Force", "Momentum"],
//       "answer": "Acceleration"
//     },
//     {
//       "question": "What is the main cause of tides on Earth?",
//       "options": [
//         "Wind",
//         "Earth's rotation",
//         "Gravitational pull of the Moon and Sun",
//         "Earth's shape"
//       ],
//       "answer": "Gravitational pull of the Moon and Sun"
//     },
//     {
//       "question": "The force required to stop a moving object is called:",
//       "options": ["Impulse", "Friction", "Momentum", "Work"],
//       "answer": "Impulse"
//     },
//     {
//       "question": "The temperature at which the kinetic energy of particles is zero is:",
//       "options": ["0°C", "273 K", "-273°C", "0 K"],
//       "answer": "0 K"
//     },
//     {
//       "question": "A battery converts chemical energy into:",
//       "options": ["Electrical energy", "Kinetic energy", "Light energy", "Heat energy"],
//       "answer": "Electrical energy"
//     },
//     {
//       "question": "The law of inertia states that:",
//       "options": [
//         "An object will remain at rest unless acted upon by an external force",
//         "An object will move in a straight line unless acted upon by an external force",
//         "An object will remain at rest or in uniform motion unless acted upon by an external force",
//         "Both A and B"
//       ],
//       "answer": "An object will remain at rest or in uniform motion unless acted upon by an external force"
//     },
//     {
//       "question": "The force of gravity is:",
//       "options": [
//         "Directly proportional to the mass of an object",
//         "Directly proportional to the distance between objects",
//         "Inversely proportional to the mass of an object",
//         "Inversely proportional to the distance between objects"
//       ],
//       "answer": "Directly proportional to the mass of an object"
//     },
//     {
//       "question": "The bending of light around obstacles is called:",
//       "options": ["Diffraction", "Refraction", "Reflection", "Dispersion"],
//       "answer": "Diffraction"
//     },
//     {
//       "question": "The phenomenon where sound waves bounce back after hitting a surface is called:",
//       "options": ["Refraction", "Diffraction", "Reflection", "Absorption"],
//       "answer": "Reflection"
//     },
//     {
//       "question": "A force of 10 N is applied to an object of mass 2 kg. What is the acceleration?",
//       "options": ["5 m/s²", "2 m/s²", "10 m/s²", "0.5 m/s²"],
//       "answer": "5 m/s²"
//     },
//     {
//       "question": "What is the power consumed by an electric device operating at a voltage of 12 V and drawing a current of 2 A?",
//       "options": ["24 W", "6 W", "36 W", "12 W"],
//       "answer": "24 W"
//     },
//     {
//       "question": "In a magnetic field, the direction of force on a charged particle depends on:",
//       "options": [
//         "The charge of the particle",
//         "The velocity of the particle",
//         "The direction of the magnetic field",
//         "All of the above"
//       ],
//       "answer": "All of the above"
//     }
//   ]
// };
// Future<void> dataEntry() async {
//   // Reference to Firestore collection
//   final _firestore = FirebaseFirestore.instance;

//   // Creating a map where page numbers are fields
//   Map<String, dynamic> dataToStore = {};

//   for (var entry in mcqsByPage.entries) {
//     int pageNumber = entry.key;
//     List<Map<String, dynamic>> mcqs = entry.value;

//     // Store MCQs array under the page number field
//     dataToStore[pageNumber.toString()] = mcqs;
//   }

//   // Upload all pages under the 'english' document in the 'mcqs' collection
//   await _firestore
//       .collection('mcqs')
//       .doc('physics')
//       .set(dataToStore, SetOptions(merge: true));

//   print("All pages uploaded successfully.");
// }
