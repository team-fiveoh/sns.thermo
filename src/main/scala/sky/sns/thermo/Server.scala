package sky.sns.thermo

import java.io.IOException
import grizzled.net._


object Server {
  def main(args: Array[String]) {
    if (args.length != 2) {
      println("Please specify listen port and path to report file")
      System.exit(1)
    }

    val port = args(0).toInt
    val reportFile = args(1)

    new Server(port, reportFile).start
  }
}

class Server(port: Int, reportFile: String) {
  def start {
    try {
      val socket = UDPDatagramSocket(port)

      val temperatureState = new TemperatureState

      println("thermo server listening on port " + port)

      while (true) {
        val messageFromAgent = socket.receiveString(1024)
        new ConnectionHandler(messageFromAgent, temperatureState, reportFile).start()
      }

      socket.close()

    } catch {
      case ioe: IOException =>
        System.err.println("Could not listen on port " + port)
    }
  }
}
