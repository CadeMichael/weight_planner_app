// this class handles the simple equations by which one rep max and the
// intensities are calculated

class WorkoutMath {
  static double oneRepMax(int reps, double weight) {
    double rm = weight / (1.0278 - 0.0278 * reps);
    return rm;
  }

  static double relativeIntensity(reps, weight, rm) {
    double maxWeight = rm * (1.0278 - 0.0278 * reps);
    double ai = (weight) / rm;
    double ri = ai / (maxWeight / rm);
    return ri;
  }

  static double increasedAi(int reps, double desiredRi) {
    double mi = (1.0278 - 0.0278 * reps);
    double newAi = (mi * desiredRi) / 100;
    return newAi;
  }
}
