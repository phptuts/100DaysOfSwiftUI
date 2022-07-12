//
//  AddBookView.swift
//  BookWorm
//
//  Created by Noah Glaser on 7/11/22.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var review = ""
    @State private var genre = ""

    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Name of Book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Ok") {
                        let myNewBook = Book(context: moc)
                        myNewBook.title = title
                        myNewBook.id = UUID()
                        myNewBook.author = author
                        myNewBook.rating = Int16(rating)
                        myNewBook.genre = genre
                        myNewBook.review = review
                        try? moc.save()
                        dismiss()
                    }
                }
            }.navigationTitle("Add Button")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
