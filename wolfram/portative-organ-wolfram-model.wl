(* Portative Organ parametric/symbolic acoustic model.
   All numeric physical inputs are estimates pending measurement, not fabrication authority. *)

ClearAll["Global`*"];

portativeOrganMetadata = <|
  "instrument" -> "Portative Organ",
  "packet" -> "portative-organ",
  "modelName" -> "Parametric flue-pipe rank and wind-reservoir study",
  "authority" -> "reference_only - estimates pending measurement",
  "wolframVersionTarget" -> "14.3"
|>;

speedOfSoundEstimate = 343.0; (* estimate — pending measurement, not fabrication authority *)
openPipeLengthEstimate = 0.30; (* estimate — pending measurement, not fabrication authority *)
stoppedPipeLengthEstimate = 0.15; (* estimate — pending measurement, not fabrication authority *)
pipeRadiusEstimate = 0.0075; (* estimate — pending measurement, not fabrication authority *)
endCorrectionRadiusFactorEstimate = 0.6; (* estimate — pending measurement, not fabrication authority *)
windPressureEstimate = 250.0; (* estimate — pending measurement, not fabrication authority *)
airDensityEstimate = 1.2; (* estimate — pending measurement, not fabrication authority *)
pipeFootAreaEstimate = 0.00005; (* estimate — pending measurement, not fabrication authority *)
activePipeCountEstimate = 3; (* estimate — pending measurement, not fabrication authority *)
reservoirVolumeEstimate = 0.002; (* estimate — pending measurement, not fabrication authority *)
pipeLengthMinimumEstimate = 0.08; (* estimate — pending measurement, not fabrication authority *)
pipeLengthMaximumEstimate = 0.80; (* estimate — pending measurement, not fabrication authority *)
pipeRadiusMinimumEstimate = 0.002; (* estimate — pending measurement, not fabrication authority *)
pipeRadiusMaximumEstimate = 0.025; (* estimate — pending measurement, not fabrication authority *)
endCorrectionRadiusFactorMinimumEstimate = 0.0; (* estimate — pending measurement, not fabrication authority *)
endCorrectionRadiusFactorMaximumEstimate = 1.2; (* estimate — pending measurement, not fabrication authority *)
speedOfSoundMinimumEstimate = 320.0; (* estimate — pending measurement, not fabrication authority *)
speedOfSoundMaximumEstimate = 360.0; (* estimate — pending measurement, not fabrication authority *)
windPressureMinimumEstimate = 50.0; (* estimate — pending measurement, not fabrication authority *)
windPressureMaximumEstimate = 1000.0; (* estimate — pending measurement, not fabrication authority *)
airDensityMinimumEstimate = 0.9; (* estimate — pending measurement, not fabrication authority *)
airDensityMaximumEstimate = 1.4; (* estimate — pending measurement, not fabrication authority *)
pipeFootAreaMinimumEstimate = 0.00001; (* estimate — pending measurement, not fabrication authority *)
pipeFootAreaMaximumEstimate = 0.0003; (* estimate — pending measurement, not fabrication authority *)
activePipeCountMinimumEstimate = 1; (* estimate — pending measurement, not fabrication authority *)
activePipeCountMaximumEstimate = 8; (* estimate — pending measurement, not fabrication authority *)
activePipeCountStepEstimate = 1; (* estimate — pending measurement, not fabrication authority *)
reservoirVolumeMinimumEstimate = 0.0005; (* estimate — pending measurement, not fabrication authority *)
reservoirVolumeMaximumEstimate = 0.02; (* estimate — pending measurement, not fabrication authority *)
pipeLengthRangeEstimate = {pipeLengthMinimumEstimate, pipeLengthMaximumEstimate}; (* estimate — pending measurement, not fabrication authority *)

openPipeEffectiveLength[length_, radius_, endCorrectionRadiusFactor_] :=
  length + 2 endCorrectionRadiusFactor radius;

stoppedPipeEffectiveLength[length_, radius_, endCorrectionRadiusFactor_] :=
  length + endCorrectionRadiusFactor radius;

openPipeFrequency[speed_, length_, radius_, endCorrectionRadiusFactor_] :=
  speed/(2 openPipeEffectiveLength[length, radius, endCorrectionRadiusFactor]);

stoppedPipeFrequency[speed_, length_, radius_, endCorrectionRadiusFactor_] :=
  speed/(4 stoppedPipeEffectiveLength[length, radius, endCorrectionRadiusFactor]);

orificeVelocity[pressure_, density_] := Sqrt[2 pressure/density];

rankFlowEstimate[activePipes_, footArea_, pressure_, density_] :=
  activePipes footArea orificeVelocity[pressure, density];

reservoirTimeConstantEstimate[volume_, activePipes_, footArea_, pressure_, density_] :=
  volume/rankFlowEstimate[activePipes, footArea, pressure, density];

frequencySensitivityTable[length_, radius_, endCorrectionRadiusFactor_, speed_] :=
  Dataset[{
    <|
      "pipeBranch" -> "open_open",
      "frequencyHz" -> openPipeFrequency[speed, length, radius, endCorrectionRadiusFactor],
      "effectiveLengthM" -> openPipeEffectiveLength[length, radius, endCorrectionRadiusFactor]
    |>,
    <|
      "pipeBranch" -> "stopped",
      "frequencyHz" -> stoppedPipeFrequency[speed, length, radius, endCorrectionRadiusFactor],
      "effectiveLengthM" -> stoppedPipeEffectiveLength[length, radius, endCorrectionRadiusFactor]
    |>
  }];

portativeOrganStudy[length_, radius_, endCorrectionRadiusFactor_, speed_, pressure_,
    density_, footArea_, activePipes_, reservoirVolume_] :=
  <|
    "metadata" -> portativeOrganMetadata,
    "frequencyRelationships" ->
      frequencySensitivityTable[length, radius, endCorrectionRadiusFactor, speed],
    "estimatedRankFlowM3PerS" ->
      rankFlowEstimate[activePipes, footArea, pressure, density],
    "estimatedReservoirTimeS" ->
      reservoirTimeConstantEstimate[reservoirVolume, activePipes, footArea, pressure, density],
    "authorityNote" ->
      "All numeric values are placeholders pending measurement; use relationships only."
  |>;

portativeOrganDefaultStudy =
  portativeOrganStudy[
    openPipeLengthEstimate,
    pipeRadiusEstimate,
    endCorrectionRadiusFactorEstimate,
    speedOfSoundEstimate,
    windPressureEstimate,
    airDensityEstimate,
    pipeFootAreaEstimate,
    activePipeCountEstimate,
    reservoirVolumeEstimate
  ];

portativeOrganManipulate =
  Manipulate[
    Column[{
      Style["Portative organ flue-pipe relationship study", 14, Bold],
      "Reference only: every numeric input is an estimate pending measurement.",
      frequencySensitivityTable[
        pipeLength,
        pipeRadius,
        endCorrectionRadiusFactor,
        speedOfSound
      ],
      Plot[
        {
          openPipeFrequency[speedOfSound, l, pipeRadius, endCorrectionRadiusFactor],
          stoppedPipeFrequency[speedOfSound, l, pipeRadius, endCorrectionRadiusFactor]
        },
        {l, Min[pipeLengthRange], Max[pipeLengthRange]},
        PlotLegends -> {"open-open relationship", "stopped relationship"},
        AxesLabel -> {"pipe length (m)", "frequency (Hz)"}
      ],
      Row[{
        "Estimated active-rank flow: ",
        NumberForm[
          rankFlowEstimate[activePipes, footArea, windPressure, airDensity],
          {6, 5}
        ],
        " m^3/s"
      }],
      Row[{
        "Estimated reservoir time: ",
        NumberForm[
          reservoirTimeConstantEstimate[
            reservoirVolume,
            activePipes,
            footArea,
            windPressure,
            airDensity
          ],
          {6, 3}
        ],
        " s"
      }]
    }],
    {{pipeLength, openPipeLengthEstimate, "pipe length estimate (m)"}, pipeLengthMinimumEstimate, pipeLengthMaximumEstimate, Appearance -> "Labeled"},
    {{pipeRadius, pipeRadiusEstimate, "pipe radius estimate (m)"}, pipeRadiusMinimumEstimate, pipeRadiusMaximumEstimate, Appearance -> "Labeled"},
    {{endCorrectionRadiusFactor, endCorrectionRadiusFactorEstimate, "end-correction radius factor estimate"}, endCorrectionRadiusFactorMinimumEstimate, endCorrectionRadiusFactorMaximumEstimate, Appearance -> "Labeled"},
    {{speedOfSound, speedOfSoundEstimate, "speed of sound estimate (m/s)"}, speedOfSoundMinimumEstimate, speedOfSoundMaximumEstimate, Appearance -> "Labeled"},
    {{windPressure, windPressureEstimate, "wind pressure estimate (Pa)"}, windPressureMinimumEstimate, windPressureMaximumEstimate, Appearance -> "Labeled"},
    {{airDensity, airDensityEstimate, "air density estimate (kg/m^3)"}, airDensityMinimumEstimate, airDensityMaximumEstimate, Appearance -> "Labeled"},
    {{footArea, pipeFootAreaEstimate, "pipe-foot area estimate (m^2)"}, pipeFootAreaMinimumEstimate, pipeFootAreaMaximumEstimate, Appearance -> "Labeled"},
    {{activePipes, activePipeCountEstimate, "active pipe count estimate"}, activePipeCountMinimumEstimate, activePipeCountMaximumEstimate, activePipeCountStepEstimate, Appearance -> "Labeled"},
    {{reservoirVolume, reservoirVolumeEstimate, "reservoir volume estimate (m^3)"}, reservoirVolumeMinimumEstimate, reservoirVolumeMaximumEstimate, Appearance -> "Labeled"},
    {{pipeLengthRange, pipeLengthRangeEstimate, "plot length range estimate (m)"}, ControlType -> None},
    SaveDefinitions -> True
  ];

portativeOrganModel = <|
  "metadata" -> portativeOrganMetadata,
  "defaultStudy" -> portativeOrganDefaultStudy,
  "explorer" -> portativeOrganManipulate
|>;

portativeOrganModel
