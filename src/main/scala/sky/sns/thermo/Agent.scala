package sky.sns.thermo

import java.util.concurrent.{TimeUnit, Executors}
import io.Source
import java.io.File
import java.net.{DatagramPacket, InetSocketAddress, DatagramSocket}

class Agent(agentId: Int, temperatureData: File, server: String, port: Int) {
  val scheduler = Executors.newSingleThreadScheduledExecutor()
  val temperatureFilePattern = """\d+\s+,\s+\d+/\d+/\d+ \d+:\d+:\d+\s+,\s+(\d+\.\d+) C""".r
  val pollingInterval = 5

  def start {
    scheduler.scheduleAtFixedRate(new Runnable {
      def run {
        val lastLineOfFile = Source.fromFile(temperatureData).getLines.toList.last

        lastLineOfFile match {

          case temperatureFilePattern(degrees) =>
            send(agentId, degrees.toFloat)

          case _ =>
            println(" read some funny input: " + lastLineOfFile)
        }

      }
    }, pollingInterval, pollingInterval, TimeUnit.SECONDS)
  }

  private def send(agentId: Int, degrees: Float) {
    val message = agentId + " " + degrees
    val messageBytes = message.getBytes

    val socket = new DatagramSocket(new InetSocketAddress(server, port))
    socket.send(new DatagramPacket(messageBytes, messageBytes.length))
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

    new Agent(agentId, file, server, port).start
  }

  def exitWithMessage(message: String) = {
    Console.println(message)
    System.exit(1)
  }
}