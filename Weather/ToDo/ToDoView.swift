//
//  ToDoView.swift
//  PersonalOverView
//
//  Created by Jan Hovland on 24/09/2020.
//

import SwiftUI

var toDo_1 =
    """

    i O S :

    1. 🛑 Få med snø i nedbør
 
"""

var toDo_2 =
    """
F e r d i g
 
"""

var toDo_3 =
    """

  1. 🟢 Legg inn refresh på CityMainView().
  2. 🟢 Fullføre hourlyRecordVerticalView().
  3. 🟢 Har lagt rain variablene inn i struct: Precipitation.
  4. 🟢 Lagt inn soloppgang og solnedgang i de neste 48 timene.
  5. 🟢 Graphene har nå riktig startpunkt:
          . CityLineViewMinutes
          . CityLineViewHours
  6. 🟢 Rettet "minutesUntilRainStops".
  7. 🟢 Rettet visningen av nedbøren.
  8. 🟢 Lagt inn vind og vindkast på 48 hour scroll.
  9. 🟢 Tatt bort vær-relaterte felter fra City tabellen (Fordi disse ikke blir oppdatert etter å ha lagret city). 
 10. 🟢 Legge inn:
        . 🟢 Soloppgang
        . 🟢 Soloppgang
 11. 🟢 . Legge API nøkkelen inn i iPhone/iPad/iMac sine Innstillinger.
        . 🟢 iPhone / iPad
        . 🔴 iMac
 12. 🔴



"""
var toDo_4 =
    """
S e n e r e

"""
var toDo_5 =
    """
  1. 🔴

"""
var toDo_6 =
    """
    K j e n t e   f e i l

    """

var toDo_7 =
    """

      1. 🔴
    
    """

var toDo_8 =
    """

    P R A K T I S K E   T I P S

    """

var toDo_9 =
    """
      1. DispatchQueue.global().sync {
             writeJsonPersonBackup()
             /// sleep() takes seconds
             /// sleep(4)
             /// usleep() takes millionths of a second
             usleep(4000000)
          }

      2. DispatchQueue.global().async {
            /// Starte ActivityIndicator
            indicatorShowing = true
            CloudKitPerson.deleteAllPersons()
            /// Stoppe ActivityIndicator
            indicatorShowing = false
        }
        message = result
        alertIdentifier = AlertID(id: .first)

    """

struct ToDoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                    Text(toDo_1)
                        .font(.custom("Andale Mono Normal", size: 17))
                        .multilineTextAlignment(.leading)
                    Text(toDo_2)
                        .font(.custom("Andale Mono Normal", size: 20)).bold()
                        .foregroundColor(.accentColor)
                    Text(toDo_3)
                        .font(.custom("Andale Mono Normal", size: 17))
                        .multilineTextAlignment(.leading)
                    Text(toDo_4)
                        .font(.custom("Andale Mono Normal", size: 20)).bold()
                        .foregroundColor(.accentColor)
                    Text(toDo_5)
                        .font(.custom("Andale Mono Normal", size: 17))
                        .multilineTextAlignment(.leading)
                    Text(toDo_6)
                        .font(.custom("Andale Mono Normal", size: 20)).bold()
                        .foregroundColor(.red)
                    Text(toDo_7)
                        .font(.custom("Andale Mono Normal", size: 17))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.red)
                    Text(toDo_8)
                        .font(.custom("Andale Mono Normal", size: 17))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.green)
                    Text(toDo_9)
                        .font(.custom("Andale Mono Normal", size: 17))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.green)
                    
                }
            }
            .padding()
            .navigationBarTitle(Text("toDo"), displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Text("Cancel")
                                    }
                                ))
        }
    }
}

