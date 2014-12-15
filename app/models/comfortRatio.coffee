#_ = require 'lodash'

resultOptions = [
  'Light racing multi-hull'
  'Ultra-light ocean racer'
  'Very light ocean racer'
  'Light cruiser/racer'
  'Light cruising auxiliary' # Coastal cruisers.
  'Average cruising auxiliary' # Ocean cruisers.
  'Heavy cruising auxiliary' # Heavy cruisers and motorsailers.
  'Very heavy cruising auxiliary'
]

scale =
  csf: [1.25, 1.6, 2, 2.25, 2.5, 2.75, 4, 20]
  dl: [55, 100, 150, 200, 250, 300, 350, 400]
  sad: [14, 16, 18, 19, 20, 21, 25, 50]
  cr: [10, 15, 20, 25, 30, 40, 45, 50]

module.exports =
  # http://www.sailingcourse.com/keelboat/motion_comfort.htm
  # http://wavetrain.net/boats-a-gear/281-crunching-numbers-brewer-comfort-ratio
  # Comfort ratio
  cr: (loa, lwl, disp, beam) ->
    parseInt disp / (.65 * ((.7 * lwl) + (.3 * loa)) * Math.pow(beam, (4/3)))

  # CAPSIZE SCREENING FORMULA
  csf: (beam, disp) ->
    beam / (Math.pow (disp / 64), 1/3)

  # Sail Angle Displacement Ratio
  sad: () ->
    return

  # Screening Stability Value ( SSV )
  ssv: () ->
    #  =  ( Beam 2 ) / ( BR * HD * DV 1/3 )
    # Displacement Volume in Cubic Meters = ( Weight in Pounds / 64 )*0.0283168
    return

  # Angle vanishing stability. Limit of positive stability. Point of no return.
  avs: (beam, weight, keel, draft) ->

    # Angle of Vanishing Stability approximately equals  110 + ( 400 / (SSV-10) )

  lps: @avs

  dlResult: (type, val, reverse) ->
    index = 0
    typeScale = scale[type]
    typeScale.forEach (num, i) ->
      if val < num
        index = i
        return false
    if reverse
      resultOptions.reverse()
      res = resultOptions[index]
      resultOptions.reverse()
    else
      res = resultOptions[index]
    res
