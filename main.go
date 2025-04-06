package main

import (
    "fmt"
    "net"
    "os"
)

var version = "unknown"

func main() {
    host, _ := os.Hostname()
    ip := "unknown"

    ifaces, _ := net.Interfaces()
    for _, iface := range ifaces {
        addrs, _ := iface.Addrs()
        for _, addr := range addrs {
            ipnet, ok := addr.(*net.IPNet)
            if ok && ipnet.IP.To4() != nil && !ipnet.IP.IsLoopback() {
                ip = ipnet.IP.String()
                break
            }
        }
        if ip != "unknown" {
            break
        }
    }

    fmt.Println("Adres IP serwera:", ip)
    fmt.Println("Nazwa serwera:", host)
    fmt.Println("Wersja aplikacji:", version)
}