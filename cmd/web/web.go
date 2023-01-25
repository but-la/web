package main

import (
	"os"

	"github.com/dbut2/butla/configs"
	"github.com/dbut2/butla/internal/web"
)

func main() {
	env := os.Getenv("ENV")
	if env == "" {
		env = "default"
	}

	config, err := configs.LoadConfig(env)
	if err != nil {
		panic(err.Error())
	}

	port := os.Getenv("PORT")
	if port != "" {
		config.Web.Address = ":" + port
	}

	server, err := web.New(config.Web)
	if err != nil {
		panic(err.Error())
	}

	err = server.Run()
	if err != nil {
		panic(err.Error())
	}
}