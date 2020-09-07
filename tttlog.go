package main

import (
	"encoding/csv"
	"log"
	"os"
	"path"
	"strconv"
	"strings"
	"time"
)

func getHistoryFile() (histfile string) {
	// use TTT_HISTFILE, else ${XDG_DATA_HOME:-~/.local/share}/ttt_history.csv
	histfile = os.Getenv("TTT_HISTFILE")
	if histfile == "" {
		data_dir := os.Getenv("XDG_DATA_HOME")
		if data_dir == "" {
			home := os.Getenv("HOME")
			data_dir = path.Join(home, ".local", "share")
		}
		histfile = path.Join(data_dir, "ttt_history.csv")
	}
	return
}

func getWorkingDirectory() string {
	cwd, err := os.Getwd()
	if err != nil {
		cwd = "-"
	}
	return cwd
}

func getEpochTime() string {
	return strconv.FormatInt(time.Now().Unix(), 10)
}

func addToFile(histfile string, data []string) {
	f, err := os.OpenFile(histfile, os.O_WRONLY|os.O_CREATE|os.O_APPEND, 0644)
	if err != nil {
		log.Fatalf("%s\n", err)
	}
	defer f.Close()
	w := csv.NewWriter(f)
	w.Write(data)
	w.Flush()
}

func main() {
	addToFile(getHistoryFile(), []string{getEpochTime(), getWorkingDirectory(), strings.Join(os.Args[1:], " ")})
}
