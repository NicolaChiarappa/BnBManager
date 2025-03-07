


import SwiftUI

struct HomeView : View{
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    var body : some View{
        NavigationStack{
            
            ScrollView{
                
                TagGroup()
                Spacer()
                StatuSection()
                    .padding()
                Spacer()
                ArrivingGuestsSection()
                    .padding()
                Spacer()
                TodoSection()
                    .padding()
                Spacer()
                Button("Save"){
                    homeViewModel.many()
                }
                ForEach(homeViewModel.dataManager.rooms, id: \.self){
                    room in
                    Text(room.ID.description)
                }
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
            
            
            .navigationTitle("Overview")
            .sheet(isPresented: $homeViewModel.isArrivingActive) {
                ArrivingGuestPage()
            }
            
            .environmentObject(homeViewModel)
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
    let today = Date.now
    var body: some View{
        if(selected==index){
            Text(self.index.description=="0" ? "Today"
                 : self.index.description=="1" ? "Tomorrow"
                 :today.addingTimeInterval(TimeInterval(3600*24*index)).formatted(date:.abbreviated, time:.omitted)
            )
            .tag()
            .selected()
        }
        else{
            Text(self.index.description=="0" ? "Today"
                 : self.index.description=="1" ? "Tomorrow"
                 :today.addingTimeInterval(TimeInterval(3600*24*index)).formatted(date:.abbreviated, time:.omitted)
            )
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
        .foregroundStyle(.primary)
    }
    
}

struct TodoLabel:View{
    
    var details:String
    var index:Int
    var body: some View{
        LazyVStack(spacing: 12){
            HStack{
                VStack(alignment: .trailing){
                    Text("\(index)th task to do")
                        .bold()
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(self.details)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(maxWidth: .infinity)
                
                Button("Done"){}
                    .background(Color(.systemGreen).opacity(0.5))
                    .clipShape(.buttonBorder)
                    .buttonStyle(.bordered)
                    .foregroundStyle(.primary)
            }
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 0.3)
                .foregroundStyle(Color(.systemGray3))
                .padding(.horizontal, -16)
                .padding(.vertical, 2)
            
            
        }
        .transition(.slide)
        
    }
    
}

struct ArrivingGuestsSection: View {
    @EnvironmentObject var homeViewModel:HomeViewModel
    
    var body: some View {
        VStack() {
            HStack {
                HStack {
                    Text("Arriving guests")
                        .font(.title)
                        .bold()
                    Image(systemName: "arrow.down")
                        .bold()
                    Spacer()
                   
                }
                    
                HStack {
                    Text("Show all")
                        .frame(alignment: .trailing)
                        .font(.subheadline)
                    Image(systemName: "chevron.right")
                }
                .frame(alignment: .trailing)
                .onTapGesture {
                    homeViewModel.isArrivingActive=true
                }
               
                
            }
            .frame(maxWidth: .infinity)
        
            ForEach(1..<5){ i in
                BookLabel(room: i, people: 2*i)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

struct TodoSection:View{
    var body: some View{
        VStack {
            HStack{
                Text("ToDo")
                    .font(.title)
                    .bold()
                Image(systemName: "checklist.checked")
                    .bold()
                Spacer()
            }
            .frame(alignment: .leading)
            
            
            LazyVStack(alignment: .trailing, spacing: 17){
                ForEach(0..<8){
                         i in
                    TodoLabel(details: "Some detail about task", index: i+1)
                        .listRowSeparator(.visible)
                                
                
                   
                }
            }
           
        }
        
    }
}

struct ArrivingGuestPage:View{
    @EnvironmentObject var homeViewModel:HomeViewModel
    var body: some View{
        NavigationStack{
            List{
                ForEach(1..<5){ i in
                    BookLabel(room: i, people: 2*i)
                }
            }
            .listStyle(.plain)
            
            .toolbar(){
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        homeViewModel.isArrivingActive=false
                    }
                }
                    
            }
            .navigationTitle("Arriving guests")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct StatuSection:View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Available")
                .frame(alignment: .leading)
                
                .font(.title)
                .bold()
            HStack{
                Label("3", systemImage: "square.split.bottomrightquarter")
                    .font(.title2)
                    .bold()
                Label("6", systemImage: "person.3.sequence")
                    .font(.title2)
                    .bold()
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
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
