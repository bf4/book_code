#include "gps.h"
#include <iostream>

using std::cout;
using std::endl;

namespace messy {

    Trip::Point::Point(double lat, double lon, double time) :
        lat_(lat), lon_(lon), time_(time) {
    }

    double Trip::Point::lat() const {
        return lat_;
    }

    double Trip::Point::lon() const {
        return lon_;
    }

    double Trip::Point::time() const {
        return time_;
    }

    void Trip::addPoint(double lat, double lon, double time) {
        points_.push_back(Point(lat, lon, time));
    }

    void Trip::setName(const std::string& name) {
        name_ = name;
    }

    std::string Trip::name() const {
        return name_;
    }

    size_t Trip::count() const {
        return points_.size();
    }

    const Trip::Point& Trip::getPoint(size_t index) const {
        return points_[index];
    }

}

int main() {
    {
        messy::Trip trip;
        trip.addPoint(32.9, -97.3,  0.0);
        trip.addPoint(45.6, -122.6, 4320.0);

        cout << "Messy trip has " << trip.count() << " points" << endl;

        for (size_t i = 0; i < trip.count(); ++i) {
            const messy::Trip::Point& p = trip.getPoint(i);
            cout << "Point #" << (i + 1)
                 << ": ("    << p.lat()
                 << ","      << p.lon()
                 << ") at time "  << p.time() << endl;
        }
    }

    {
        clean::BikeTrip trip;

        trip.add(clean::BikeLocation(32.9, -97.3),  0.0);
        trip.add(clean::BikeLocation(45.6, -122.6), 4320.0);

        const double time = 1000.0;
        clean::BikeLocation location = trip(time);

        cout << "Clean trip was at location ("
             << location.first << ","
             << location.second << ") at time "
             << time << endl;
    }


    return 0;
}
