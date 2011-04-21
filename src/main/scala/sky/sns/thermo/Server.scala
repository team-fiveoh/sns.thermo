package sky.sns.thermo

import java.io.IOException
import grizzled.net._


object Server extends Application {
  val port = 2222
  val reportFile = "report.txt"

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

