package sky.sns.thermo

import java.util.concurrent.{TimeUnit, Executors}
import io.Source
import java.io.File
import grizzled.net._


class Agent(agentId: Int, temperatureData: File, server: String, port: Int) {
  val scheduler = Executors.newSingleThreadScheduledExecutor()
  val temperatureFilePattern = """\d+\s+,\s+\d+/\d+/\d+ \d+:\d+:\d+\s+,\s+(\d+\.\d+) C""".r
  val pollingInterval = 1

  def start {
    scheduler.scheduleAtFixedRate(new Runnable {
      def run() {
        val lastLineOfFile = Source.fromFile(temperatureData).getLines.toList.last

        lastLineOfFile match {

          case temperatureFilePattern(degrees) =>
            send(agentId, degrees)

          case _ =>
            Console.println(" read some funny input: " + lastLineOfFile)
        }

      }
    }, pollingInterval, pollingInterval, TimeUnit.SECONDS)
  }

  private def send(agentId: Int, degrees: String) {
    val message = agentId + " " + degrees
    UDPDatagramSocket.sendString(message, IPAddress(server), port)

    println(" - sent " + message + " to " + server + ":" + port)
  }
}

object Agent {
  def main(args: Array[String]) {
    if (args.length != 4) {
      exitWithMessage("Please specify agent ID, server to connect to, port to connect to, and file name of temperature data.")
    }

    val agentId = args(0).toInt;
    val server = args(1)
    val port = args(2).toInt
    val file = new File(args(3))

    if (!file.exists) {
      exitWithMessage("File does not exist")
    }

    println("starting agent")
    new Agent(agentId, file, server, port).start
  }

  def exitWithMessage(message: String) = {
    println(message)
    System.exit(1)
  }
}