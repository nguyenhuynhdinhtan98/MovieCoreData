//
//  ActorDetailScreen.swift
//  MovieApp
//
//  Created by Tân Nguyễn on 23/12/2022.
//

import SwiftUI

struct ActorDetailScreen: View {
    
   var actorVM = ActorViewModel(actor: Actor(context:  Actor.viewContext))
    var body: some View {
        VStack {
            List(actorVM.movies, id: \.id) { item in
                Text("\(item.title)")
            }.listStyle(PlainListStyle())
        }.navigationTitle(actorVM.name)
    }
}

struct ActorDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActorDetailScreen()
    }
}
