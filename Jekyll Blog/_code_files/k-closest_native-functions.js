function kClosest(points, k) {
  const closest = points.reduce((result, point, index) => {
      if (result.length < k) {
          if (distance(point, [0, 0]) < distance(points[index + 1], [0, 0])) {
              result.push(point);
          } else {
              result.push(points[index + 1]);
          }
      }                            
      return result
  }, [])
  
  return closest
};

function distance(p1, p2) {
  return p1[0] * p1[0] + p1[1] * p1[1] - p2[0] * p2[0] + p2[1] * p2[1]
};
