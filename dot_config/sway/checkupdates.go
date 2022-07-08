package main

import (
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"time"

	"github.com/sirupsen/logrus"
)

func main() {
	homeDir := os.Getenv("HOME")

	checkupdateFilename := ".conky_checkupdates"
	go checkupdates(filepath.Join(homeDir, checkupdateFilename))

	conkyConfigFilename := ".conkyrc"
	conkyRun(filepath.Join(homeDir, conkyConfigFilename))
}

func checkupdates(filepath string) {
	d := 10 * time.Minute
	runCheckUpdates(filepath, d)
}

func runCheckUpdates(filepath string, d time.Duration) {
	for {
		cmd := exec.Command("yay", "-Qu")
		b, err := cmd.CombinedOutput()
		if err != nil {
			logrus.WithFields(logrus.Fields{
				"error": err,
			}).Error("Failed to get checkupdate messages")
			b = []byte(fmt.Sprintf("Failed to get checkupdate messages: %v\n", err))
		}

		content := string(b)

		err = writeInfo(filepath, strings.NewReader(content))
		if err != nil {
			logrus.WithFields(logrus.Fields{
				"error": err,
			}).Error("Failed to write all content of updates to file")
		}
		time.Sleep(d)
	}
}

func format(s []string) io.Reader {
	return strings.NewReader(strings.Join(s, "\n"))
}

func writeInfo(filepath string, r io.Reader) error {
	fd, err := os.Create(filepath)
	if err != nil {
		logrus.WithFields(logrus.Fields{
			"error":    err,
			"filepath": filepath,
		}).Error("Failed to open file for conky")
	}
	defer fd.Close()
	_, err = io.Copy(fd, r)
	return err
}

func conkyRun(ccf string) {
	fmt.Println(`{"version":1}`)
	fmt.Println("[\n[],")

	// restart conky if it fail without reason
	for {
		conky(ccf)
		time.Sleep(1)
	}
}

func conky(ccf string) {
	cmd := exec.Command("conky", "-c", ccf)
	cmd.Stdout = os.Stdout

	err := cmd.Run()
	if err != nil {
		logrus.WithFields(logrus.Fields{
			"error": err,
		}).Error("An error happened in the execution of the conky command")
	}
}
