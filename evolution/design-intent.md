# Design Intent — portative-organ rev A

- Master CAD: none. This repo has no `cad/portative-organ.scad` and no other
  CAD source; see `cad/README.md` for the recorded honest no-scad gap
  (no real pipe-schedule data exists anywhere in the repo to drive a
  parametric envelope).
- Driven by: `bom.csv` (sha256: 0bff28d60bda4519c09ebd3cc7bab56069e8d517c114f5c832c0511944d2d49f) and
  `cut-list.csv` (sha256: c8cfe9c64a0dc0697fa3bbbbd8d3d7d42026c99d4191751aa1e28aec6f9eeb0d) —
  both estimate-only part/blank family lists, not a dimensioned design table.
- Function: a small portable pipe organ. The player works a single-hand
  bellows while playing a one-row keyboard; the bellows feeds a wind
  reservoir, the reservoir supplies a sealed windchest, and each key opens a
  pallet valve admitting wind to a flue pipe in a single first-study rank
  (`design.md` Mechanism, `decision-record.md` Key Decisions).
- Environment: indoor practice/study instrument; portable, carried or
  lap/table/strap-supported (support mode undecided).
- Target qty: 1 (prototype). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Pipe length (first rank) | TBD | TBD | sets pitch; unresolved open-vs-stopped choice | design.md Pipes And Ranks (no value released) |
| Pipe diameter / scale | TBD | TBD | affects speech and tone | design.md (no value released) |
| Pipe scaling ratio across rank | TBD | TBD | would drive a parametric rank array if it existed | tables/pipe-scale.csv (`PO-PIPE-PLAN-001`, planned, not present) |
| Wind pressure | TBD | TBD | pipe speech onset and reservoir sizing | design.md Wind System Reasoning (no value released) |
| Pallet travel / lift | TBD | measurement_required | key-to-valve action feel and seal | validation.csv VAL-004/VAL-006 |
| Windchest seal leakage | TBD | no audible/measurable leak (target TBD) | wind stability with keys at rest | validation.csv VAL-003 |
| Reservoir volume | TBD | measurement_required | smooths bellows pulses | design.md Wind System Reasoning; validation.csv VAL-001/VAL-002 |

## Incidental (free for DFM)

- Case cosmetic finish, exact key-cap shape, decorative pipe-shade or
  facade treatment, carrying-strap hardware styling.

## Must-nots (DFM may never violate)

- Do not publish pipe lengths, pipe diameters, wind-pressure values, or
  tuning values without a measured mule or reviewed design table
  (`decision-record.md` Authority Boundary; `risks.md`).
- Do not close or finalize the windchest before a non-playing wind-system
  mule proves reservoir steadiness and pallet sealing (`bom.csv` PO-BOM-016;
  `validation.csv` VAL-001–VAL-005).
- Do not commit to a case support mode before a handling mockup shows it
  does not twist the windchest or change pallet seal behavior
  (`validation.csv` VAL-008).
- Do not scale a second rank before the first single-rank mule is proven
  (`bom.csv` PO-BOM-011; `design.md` Failure Modes).

## Material intent

- Bellows: flexible, repeatedly-sealing, repairable material (leather or
  synthetic bellows cloth) — `bom.csv` PO-BOM-001/004, `sourcing.csv`.
- Reservoir and windchest bodies: panel stock that holds flat sealing
  references — `bom.csv` PO-BOM-002/005, `sourcing.csv`.
- Pallet facing: quiet-sealing, non-sticking material, choice pending test —
  `bom.csv` PO-BOM-006, `sourcing.csv`.
- Pipe material: open until pipe-scale research and voicing tests exist —
  `design.md` Materials Reasoning, `bom.csv` PO-BOM-010.
- Case: balances weight, stiffness, and pipe protection — `bom.csv`
  PO-BOM-012/013, `sourcing.csv`.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT run —
there is no CAD master to compile. This intake documents the current
concept/pending-measurement baseline (bom.csv, cut-list.csv, wolfram source
files) honestly, including the absence of CAD and pipe-scale artifacts.
