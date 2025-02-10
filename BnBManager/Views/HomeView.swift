//
//  HomeView.swift
//  BnBManager
//
//  Created by Nicola Chiarappa on 10/02/25.
//

import SwiftUI

struct HomeView : View{
    var body : some View{
        NavigationStack{
            
            ScrollView{
                TagGroup()
                Spacer()
                ArrivingGuestsSection()
                    .padding()
                Spacer()
                Todo()
                    .padding()
            }
            
            .frame(maxWidth: .infinity)
            
            .navigationTitle("Overview")
        }
    }
}






struct TagGroup: View {
    @State var selected:Int=0
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 15) {
                Spacer(minLength: .leastNonzeroMagnitude)
                
                ForEach(0..<7){ i in
                    TagLabel(index: i, selected: selected)
                        .onTapGesture {
                            withAnimation{
                                selected=i
                            }
                            
                        }
                }
                Spacer(minLength: .leastNonzeroMagnitude)
                
            }
            .font(.callout)
            
            
            
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
    }
}





struct TagLabel: View {
    var index:Int
    var selected:Int
    var body: some View{
        if(selected==index){
            Text(self.index.description=="0" ? "Today"
                 : self.index.description=="1" ? "Tomorrow"
                 : "\(self.index.description) days")
            .tag()
            .selected()
        }
        else{
            Text(self.index.description=="0" ? "Today"
                 : self.index.description=="1" ? "Tomorrow"
                 : "\(self.index.description) days")
            .tag()
            
            
        }
        
    }
}

struct BookLabel:View{
    var room:Int
    var people:Int
    var body: some View{
        HStack{
            Circle()
                .frame(height: 55)
                
            VStack(alignment: .leading){
                Text("Name LastName")
                    .bold()
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Label("\(self.room)", systemImage: "square.split.bottomrightquarter.fill")
                        .frame(alignment: .leading)
                    
                    Label("\(self.people)", systemImage: "person.3.sequence.fill")
                        .frame(alignment: .leading)
                }
                .frame(alignment: .leading)
                
               
                
            }
            .frame(maxWidth: .infinity)
        }
    }
    
}

struct TodoLabel:View{
    var details:String
    var index:Int
    var body: some View{
        HStack{
            VStack(alignment: .center){
                Text("\(index)th task to do")
                    .bold()
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(self.details)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(maxWidth: .infinity)
            
            Button("Done"){}
                .buttonStyle(.bordered)
        }
    }
    
}

struct ArrivingGuestsSection: View {
    var body: some View {
        VStack() {
            HStack {
                HStack {
                    Text("Arriving guests")
                        .font(.title2)
                        .bold()
                    Image(systemName: "arrow.down")
                    Spacer()
                   
                }
                    
                HStack {
                    Text("Show all")
                        .frame(alignment: .trailing)
                        .font(.subheadline)
                    Image(systemName: "chevron.right")
                }
                .frame(alignment: .trailing)
               
                
            }
            .frame(maxWidth: .infinity)
        
            ForEach(1..<5){ i in
                BookLabel(room: i, people: 2*i)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

struct Todo:View{
    var body: some View{
        VStack {
            HStack{
                Text("ToDo")
                    .font(.title2)
                    .bold()
                Image(systemName: "checklist.checked")
                Spacer()
            }
            .frame(alignment: .leading)
            
            ForEach(0..<9){ i in
                TodoLabel(details: "Some detail about task", index: i+1)
                    .padding(.vertical, 4)
                
            }
           
        }
        
    }
}






//Custom modifiers
struct Tag:ViewModifier{
    func body(content: Content) -> some View {
        content
            .bold()
            .padding(.horizontal, 15)
            .padding(.vertical, 9)
            .background(
                Color(UIColor.secondarySystemFill)
            )
            .clipShape(.capsule)
            
    }
}

struct Selected: ViewModifier{
    func body(content: Content) -> some View {
        content
            .background(
                Color(.systemGreen).opacity(0.40)
            )
            .clipShape(.capsule)
            .bold()
            
    }
}

extension View{
    func selected()->some View{
        modifier(Selected())
    }
    
    func tag()->some View{
        modifier(Tag())
    }
}

#Preview {
    HomeView()
}
