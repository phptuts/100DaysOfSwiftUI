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
    @State private var titleValid = true
    @State private var author = ""
    @State private var authorValid = true
    @State private var rating = 3
    @State private var review = ""
    @State private var reviewValid = true
    @State private var genre = "Fantasy"

    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section{
                    CustomTextField(text: $title, isValid: $titleValid, fieldName: "Title")
                    CustomTextField(text: $author, isValid: $authorValid, fieldName: "Author's name")
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    CustomTextField(text: $review, isValid: $reviewValid, fieldName: "")
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Ok") {
                        
                        titleValid = !title.isEmpty
                        authorValid = !author.isEmpty
                        reviewValid = !review.isEmpty
                        
                        if !reviewValid || !authorValid || !titleValid {
                            print("TITLE \(title) AUTHOR \(author) \(authorValid)")
                            return
                        }
                        
                        let myNewBook = Book(context: moc)
                        myNewBook.title = title
                        myNewBook.id = UUID()
                        myNewBook.author = author
                        myNewBook.rating = Int16(rating)
                        myNewBook.genre = genre
                        myNewBook.review = review
                        myNewBook.created = Date.now
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
