/***
 * Excerpted from "Seven More Languages in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
***/
#include <string>
#include <vector>

namespace messy {


class Trip
{
public:
    class Point
    {
    public:
        Point(double lat, double lon, double time);

        double lat()  const;
        double lon()  const;
        double time() const;

        // ...
    private:
        double lat_, lon_, time_;
    };

    void addPoint(double lat, double lon, double time);

    void setName(const std::string& name);
    std::string name() const;

    size_t count() const;
    const Point& getPoint(size_t index) const;

    // ...

private:
    std::vector<Point> points_;
    std::string name_;
};
}

#include <utility>

namespace clean {

template <typename Location>
class Trip
{
public:
    Location operator()(double);

    // ...
    void add(Location loc, double time);

private:
    std::vector<Location> locations_;
    std::vector<double>   times_;
};

typedef std::pair<double, double> BikeLocation;
typedef Trip<BikeLocation> BikeTrip;

#include <limits>

template <class Location>
void Trip<Location>::add(Location loc, double time) {
    // for the real thing, we'd enforce time ordering here
    locations_.push_back(loc);
    times_.push_back(time);
}

double interpolate(double t, double t1, double t2, double v1, double v2)
{
    double amount = (t - t1) / (t2 - t1);
    return v1 + (amount * (v2 - v1));
}

template <>
BikeLocation Trip<BikeLocation>::operator()(double time) {
    if (locations_.empty()) {
        return BikeLocation(std::numeric_limits<double>::quiet_NaN(),
                            std::numeric_limits<double>::quiet_NaN());
    }

    if (locations_.size() == 1) {
        return locations_[0];
    }

    size_t i = 0;
    for (; i < times_.size(); ++i) {
        if (times_[i] >= time) { break; }
    }

    if (i == 0 || i == times_.size()) {
        return locations_[i];
    }

    double beforeTime = times_[i - 1];
    double afterTime  = times_[i];

    const BikeLocation& beforeLoc = locations_[i - 1];
    const BikeLocation& afterLoc  = locations_[i];

    return BikeLocation(interpolate(time,
                                    beforeTime,       afterTime,
                                    beforeLoc.first,  afterLoc.first),
                        interpolate(time,
                                    beforeTime,       afterTime,
                                    beforeLoc.second, afterLoc.second));
}

}
