package main

import "net/http"

func handlerReadiness(w http.ResponseWriter, r *http.Request) {
	type readyResponse struct {
		Ready string `json:"health?"`
	}

	respondWithJSON(w, 200, readyResponse{
		Ready: "ok",
	})
}
