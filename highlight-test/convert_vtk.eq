//! About
//! =====
//! 
//! This file is taken from the current version of AcoDyn and its original purpose is
//! to convert AcoDyn output files to the more commonly used VTK file format.
//! As its structure is quite ~straight forward~, it is used as a _basis_ for testing the
//! **syntax highlighting** of EDL.
//!
//! ```edl
//! let a: u32 = 0;
//! ```
//!
//! ```rust
//! struct Test {}
//! ```

use std::Res;
use std::ResView;
use std::field::Field;
use std::CommandAndControl;
use std::domain::Domain;
use std::dimension::Dimensions;
use std::dimension::PhyNum;
use std::info;
use std::debug;
use std::math::SVector;
use std::log::FieldLoader;
use std::vtk::VtkBuilder;

use std::gpu;
use std::gpu::ops;
use std::time::SystemTime;
use std::time::Duration;


const SAVE_PATH: str = std::env("output");
const CONVERT_PATH: str = std::env("script.output");
const DIM: usize = std::domain::dim_first();
const NFACES: usize = std::domain::nfaces_first();

let cc = CommandAndControl::new(std::env("interactive"), "cc_handle");
let dims = Dimensions::from_project();
let domain: Domain<f64, NFACES, DIM> = Domain::first(cc);

let pressure: Field<_, 1, 1> = Field::new(domain);
let velocity: Field<_, DIM, 1> = Field::new(domain);

#[target=gpu]
impl<T, const N: usize, const M: usize> Field<T, N, M> {
    fn create<const NSIZE: usize, const DIM: usize>(domain: Domain<T, NSIZE, DIM>) -> Self {
        let mut a: usize = 0;
        Field::new(domain);
    }
}

fn main() {
    // load fields from solver.
    let loader = comptime { FieldLoader::<f64>::new(SAVE_PATH) };
    let writer = VtkBuilder::<f64, DIM>::new(CONVERT_PATH)
        .insert_geometry(domain.intern());
    // starting to read time-steps...
    loop {
        std::info("reading timestep...");
        if !loader.read(pressure.intern()) {
            std::info("Failed to read pressure from file!");
            break;
        }
        if !loader.read(velocity.intern()) {
            std::info("Failed to read velocity from file!");
            break;
        }
        re_dim_fields();
        // writing data back to VTK file
        writer
            .insert_field_data(pressure.intern(), "pressure")
            .insert_velocity_data(velocity.intern(), "velocity")
            .flush_timestep();
        break;
    }
    std::info(" °^° done!");
}

/// Is used to re-dimensionalize field data
fn re_dim_fields() {
    let meter = Res::new(1.0_f64 / dims.non_dim(PhyNum::new(1.0_f64, "m s^-1")));
    let pascal = Res::new(1.0_f64 / dims.non_dim(PhyNum::new(1.0_f64, "Pa")));
    // gpu-accelerated re-dimensionalization (lol)
    pressure.intern().scalar_scale(pascal.into());
    velocity.intern().scalar_scale(meter.into());
    gpu::synchronize();
}
