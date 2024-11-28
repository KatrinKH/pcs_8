package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
)

// Product представляет продукт
type Product struct {
	ID          int
	ImageURL    string
	Name        string
	Description string
	Price       float64
}

// Пример списка продуктов
var products = []Product{
	{
		ID: 1, 
		ImageURL: "https://ir.ozone.ru/s3/multimedia-2/wc1000/6890466278.jpg", 
		Name: "Mortal Combat 1 (2023)", 
		Description: "Mortal Kombat 1 (2023) — это перезапуск классической серии файтингов с обновлённым сюжетом, улучшенной графикой и новыми механиками боя.", 
		Price: 5299,
	},
	{
		ID: 2, 
		ImageURL: "https://ir.ozone.ru/s3/multimedia-1-0/wc1000/6922121436.jpg", 
		Name: "Atomic Heart", 
		Description: "Atomic Heart — это экшен-RPG в альтернативной реальности Советского Союза, где игрок сражается с мутировавшими существами и роботами в мире, полном загадок и технологий.", 
		Price: 2499,
	},
	{
		ID: 3, 
		ImageURL: "https://ir.ozone.ru/s3/multimedia-1-l/wc1000/7133710521.jpg", 
		Name: "Resident Evil Village", 
		Description: "Resident Evil Village — это survival horror игра, где игроки управляют Итаном Уинтерсом, который ищет свою похищенную дочь в жуткой деревне, полной опасных существ и загадок.", 
		Price: 3900,
	},
	{
		ID: 4, 
		ImageURL: "https://ir.ozone.ru/s3/multimedia-1-i/wc1000/7148120274.jpg", 
		Name: "Silent Hill 2", 
		Description: "Silent Hill 2 (2024) — это ремейк культовой хоррор-игры, в которой Джеймс Сандерленд возвращается в мрачный город Сайлент Хилл, чтобы найти свою покойную жену, сталкиваясь с ужасными созданиями и психологическими испытаниями.", 
		Price: 6400,
	},
	{
		ID: 5, 
		ImageURL: "https://upload.wikimedia.org/wikipedia/ru/d/d1/Assassin%27s_Creed_Shadows.png", 
		Name: "Assassin's Creed Shadows", 
		Description: "Assassin's Creed Shadows — это игра, в которой игроки исследуют тёмные уголки истории как новый ассассин, выполняя стелс-миссии и сражаясь с врагами в контексте политических интриг и тайных орденов.", 
		Price: 9900,
	},
	{
		ID: 6, 
		ImageURL: "https://ir.ozone.ru/s3/multimedia-1-h/wc1000/7148407301.jpg", 
		Name: "Star Wars Outlaws", 
		Description: "Star Wars Outlaws — это открытая мировая игра, где игроки управляют контрабандисткой Лау, исследуя галактику между «Империей наносит ответный удар» и «Возвращением джедая», выполняя опасные задания и сталкиваясь с моральными выборами.", 
		Price: 6990,
	},
	{
		ID: 7, 
		ImageURL: "https://upload.wikimedia.org/wikipedia/ru/thumb/c/c7/Amnesia-_The_Bunker.jpeg/548px-Amnesia-_The_Bunker.jpeg", 
		Name: "Amnesia: The Bunker", 
		Description: "Amnesia: The Bunker — это психологический хоррор, где игроки выступают в роли солдата, застрявшего в опасном подземном бункере во время Первой мировой войны, исследуя мрачные коридоры, решая головоломки и пытаясь выжить, избегая преследующего их чудовища.", 
		Price: 2300,
	},
	{
		ID: 8, 
		ImageURL: "https://ir.ozone.ru/s3/multimedia-1-7/wc1000/6971484787.jpg", 
		Name: "Spider-Man 2", 
		Description: "Spider-Man 2 — это экшен-игра с открытым миром, где игроки управляют Питером Паркером и Майлзом Моралесом, сражаясь с новыми злодеями, такими как Веном и Крейвен-охотник, и исследуя расширенный Нью-Йорк, полный приключений и интерактивных заданий.", 
		Price: 7800,
	},
	{
		ID: 9, 
		ImageURL: "https://ir.ozone.ru/s3/multimedia-s/wc1000/6902318404.jpg", 
		Name: "Hogwarts Legacy", 
		Description: "Hogwarts Legacy — это ролевая игра с открытым миром, действие которой происходит в 1800-х годах во вселенной Гарри Поттера, позволяющая игрокам создать собственного студента Хогвартса, изучать магию, выполнять задания и исследовать волшебный мир.", 
		Price: 6800,
	},
	{
		ID: 10, 
		ImageURL: "https://ir.ozone.ru/s3/multimedia-1/wc1000/6221109157.jpg", 
		Name: "Alan Wake 2", 
		Description: "Alan Wake 2 — это психологический хоррор-экшен, где игроки снова управляют писателем Аланом Уэйком, исследующим мрачный мир, полный тайн и сверхъестественных угроз, чтобы раскрыть загадки своего прошлого.", 
		Price: 4600,
	},
	{
		ID: 11, 
		ImageURL: "https://ir.ozone.ru/s3/multimedia-t/wc1000/6531475301.jpg", 
		Name: "God of War: Ragnarok", 
		Description: "God of War: Ragnarok — это продолжение приключений Кратоса и Атрея, где они исследуют миры скандинавской мифологии, сражаясь с новыми врагами и сталкиваясь с темами отцовства и предстоящего Рагнарёка.", 
		Price: 5990,
	},
}

// обработчик для GET-запроса, возвращает список продуктов
func getProductsHandler(w http.ResponseWriter, r *http.Request) {
	// Устанавливаем заголовки для правильного формата JSON
	w.Header().Set("Content-Type", "application/json")
	// Преобразуем список заметок в JSON
	json.NewEncoder(w).Encode(products)
}

// обработчик для POST-запроса, добавляет продукт
func createProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	var newProduct Product
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		fmt.Println("Error decoding request body:", err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Printf("Received new Product: %+v\n", newProduct)
	var lastID int = len(products)

	for _, productItem := range products {
		if productItem.ID > lastID {
			lastID = productItem.ID
		}
	}
	newProduct.ID = lastID + 1
	products = append(products, newProduct)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(newProduct)
}

//Добавление маршрута для получения одного продукта

func getProductByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, Product := range products {
		if Product.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(Product)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// удаление продукта по id
func deleteProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodDelete {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/delete/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем и удаляем продукт с данным ID
	for i, Product := range products {
		if Product.ID == id {
			// Удаляем продукт из среза
			products = append(products[:i], products[i+1:]...)
			w.WriteHeader(http.StatusNoContent) // Успешное удаление, нет содержимого
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновление продукта по id
func updateProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedProduct Product
	err = json.NewDecoder(r.Body).Decode(&updatedProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	// Ищем продукт для обновления
	for i, Product := range products {
		if Product.ID == id {

			products[i].ImageURL = updatedProduct.ImageURL
			products[i].Name = updatedProduct.Name
			products[i].Description = updatedProduct.Description
			products[i].Price = updatedProduct.Price

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func main() {
	http.HandleFunc("/products", getProductsHandler)           // Получить все продукты
	http.HandleFunc("/products/create", createProductHandler)  // Создать продукт
	http.HandleFunc("/products/", getProductByIDHandler)       // Получить продукт по ID
	http.HandleFunc("/products/update/", updateProductHandler) // Обновить продукт
	http.HandleFunc("/products/delete/", deleteProductHandler) // Удалить продукт

	fmt.Println("Server is running on port 8080!")
	http.ListenAndServe(":8080", nil)
}