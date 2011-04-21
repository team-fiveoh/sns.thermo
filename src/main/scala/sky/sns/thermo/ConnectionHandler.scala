package sky.sns.thermo

import actors.Actor
import org.apache.commons.io.IOUtils
import java.io.FileOutputStream

class ConnectionHandler(messageFromClient: String, temperatureState: TemperatureState, reportFile: String) extends Actor {
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
    IOUtils.write(temperatureState.print, new FileOutputStream(reportFile))
  }
}



