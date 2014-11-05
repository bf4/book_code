package com.mblinn.mbfpp.functional.coo

object Examples {

  val name = "michael bevilacqua linn"
  val initials = name.split(" ") map (_.toUpperCase) map (_.charAt(0))  mkString  
  
  case class Video(title: String, video_type: String, length: Int)
  
  val v1 = Video("Pianocat Plays Carnegie Hall", "cat", 300)
  val v2 = Video("Paint Drying", "home-improvement", 600)
  val v3 = Video("Fuzzy McMittens Live At The Apollo", "cat", 200)
  
  val videos = Vector(v1, v2, v3)
  
  def catTime(videos: Vector[Video]) =
    videos.
    filter((video) => video.video_type == "cat").
    map((video) => video.length).
    sum
  
 val vec1 = Vector(42)
 val vec2 = Vector(8)
 
 for { i1 <- vec1; i2 <- vec2 } yield(i1 + i2)
 
 val o1 = Some(42)
 val o2 = Some(8)
 
 for { v1 <- o1; v2 <- o2 } yield(v1 + v2)
 
 val o3: Option[Int] = None
 
 for { v1 <- o1; v3 <- o3 } yield(v1 + v3)
 
 case class User(name: String, id: String)
 case class Movie(name: String, id: String)
 
 def getUserById(id: String) = id match {
   case "1" => Some(User("Mike", "1"))
   case _ => None
 }
 
 def getFavoriteMovieForUser(user: User) = user match {
   case User(_, "1") => Some(Movie("Gigli", "101"))
   case _ => None
 }
 
 def getVideosForMovie(movie: Movie) = movie match {
   case Movie(_, "101") => 
     Some(Vector(
         Video("Interview With Cast", "interview", 480),
         Video("Gigli", "feature", 7260)))
   case _ => None
 }
 
 def getFavoriteVideos(userId: String) = 
   for {
     user <- getUserById(userId)
     favoriteMovie <- getFavoriteMovieForUser(user)
     favoriteVideos <- getVideosForMovie(favoriteMovie)
   } yield favoriteVideos
 
}