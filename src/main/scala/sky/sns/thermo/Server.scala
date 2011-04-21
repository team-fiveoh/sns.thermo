package sky.sns.thermo

import actors.Actor
import collection.mutable.HashMap
import org.apache.commons.io.IOUtils
import java.io.{FileOutputStream, IOException}
import grizzled.net._


object Server extends Application {
  val port = 2222

  try {
    val socket = UDPDatagramSocket(port)

    val temperatureState = new TemperatureState

    println("thermo server listening on port " + port)

    while (true) {
      val messageFromAgent = socket.receiveString(1024)
      new ConnectionHandler(messageFromAgent, temperatureState).start()
    }

    socket.close()

  } catch {
    case ioe: IOException =>
      System.err.println("Could not listen on port " + port)
  }
}

class ConnectionHandler(messageFromClient: String, temperatureState: TemperatureState) extends Actor {
  val messageFromClientPattern = """(\d+) (\d+.\d+)""".r

  def act = {
    messageFromClient match {
      case messageFromClientPattern(agentId, temperature) =>
        temperatureState.updateTemperature(agentId.toInt, BigDecimal(temperature))
        writeTemperatureFile(temperatureState)

      case _ =>
        println(" - can not decypher '" + messageFromClient + "'")
    }
  }

  private def writeTemperatureFile(temperatureState: TemperatureState) {
    IOUtils.write(temperatureState.print, new FileOutputStream("report"))
  }
}

class TemperatureState {
  val agentToTemperatureMapping = new HashMap[Int, BigDecimal]

  def updateTemperature(agentId: Int, temperature: BigDecimal) {
    agentToTemperatureMapping.put(agentId, temperature)
  }

  def print: String = {
    agentToTemperatureMapping
      .map(element => element._1 + "," + element._2)
      .mkString("\n")
  }
}