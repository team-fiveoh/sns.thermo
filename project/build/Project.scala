import com.github.retronym.OneJarProject
import sbt._

class Project(info: ProjectInfo) extends DefaultProject(info) with OneJarProject {
  val commonsIo = "commons-io" % "commons-io" % "1.4"
  val grizzled = "org.clapper" %% "grizzled-scala" % "1.0.3"

  override def mainClass = Some("sky.sns.thermo.Agent")
}