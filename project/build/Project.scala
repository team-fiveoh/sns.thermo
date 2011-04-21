import sbt._

class Project(info: ProjectInfo) extends DefaultProject(info) {
  val commonsIo = "commons-io" % "commons-io" % "1.4"
  val grizzled = "org.clapper" %% "grizzled-scala" % "1.0.3"
}