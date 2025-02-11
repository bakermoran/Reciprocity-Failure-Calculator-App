//
//  ContentView.swift
//  Reciprocity Failure Calculator
//
//  Created by Baker Moran on 2/10/25.
//

import SwiftUI

struct FilmData: Decodable, Hashable {
    let brand: String
    let stock: String
    let factor: Double
    let starts_at: Int
}

struct ContentView: View {
    // State variables for selections
    @State private var selectedBrand: String = ""
    @State private var selectedStock: String = ""
    @State private var userNumber: String = ""
    @State private var filmData: [FilmData] = []

    // Computed property to get the selected film's data
    var selectedFilm: FilmData? {
        filmData.first { $0.brand == selectedBrand && $0.stock == selectedStock }
    }

    // Computed result based on user input
    var computedResult: String {
        if let film = selectedFilm, let enteredNumber = Double(userNumber) {
            return enteredNumber < Double(film.starts_at)
                ? "\(enteredNumber)"
                : "\(pow(enteredNumber, film.factor))"
        }
        return "Enter a valid number"
    }

    // Filtered stock options based on selected brand
    var filteredStockOptions: [String] {
        filmData.filter { $0.brand == selectedBrand }.map { $0.stock }
    }

    var body: some View {
        VStack(spacing: 20) {
            Picker("Select Brand", selection: $selectedBrand) {
                ForEach(Array(Set(filmData.map { $0.brand })), id: \.self) { brand in
                    Text(brand)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)

            Picker("Select Stock", selection: $selectedStock) {
                ForEach(filteredStockOptions, id: \.self) { stock in
                    Text(stock)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)

            TextField("Exposure time", text: $userNumber)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )

            Text("Computed Result: \(computedResult)")
                .font(.headline)
                .padding()

            // Display current factor and starts_at for reference
            if let film = selectedFilm {
                Text("Starts at: \(film.starts_at)")
                Text("Factor: \(film.factor)")
            }
        }
        .padding()
        .onAppear {
            loadFilmData()
        }
    }

    // Load film data from JSON
    func loadFilmData() {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode([FilmData].self, from: data)
                filmData = decodedData
                selectedBrand = filmData.first?.brand ?? ""
                selectedStock = filteredStockOptions.first ?? ""
            } catch {
                print("Failed to load or decode JSON: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
