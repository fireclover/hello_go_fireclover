package main;
import (
    "fmt"
    "log"
    "net/http"
)
func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
        fmt.Fprintf(w, "Hello, World! FireClover on ports 3000 and 22")
    })
    fmt.Printf("Server running (ports=[3000, 22]), routes: [http://localhost:3000/, ssh://localhost:22]\n")
    go func() {
        log.Fatal(http.ListenAndServe(":22", nil))
    }()
    log.Fatal(http.ListenAndServe(":3000", nil))
}
