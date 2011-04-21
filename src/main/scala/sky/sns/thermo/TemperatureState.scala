package sky.sns.thermo

import collection.mutable.HashMap
class TemperatureState {
  val agentToTemperatureMapping = new HashMap[Int, BigDecimal]

  def updateTemperature(agentId: Int, temperature: BigDecimal) {
    agentToTemperatureMapping.put(agentId, temperature)
  }

  def asString = {
    agentToTemperatureMapping
      .map(element => element._1 + "," + element._2)
      .mkString("", "\n", "\n")
  }
}



