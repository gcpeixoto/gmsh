/********************************************************************* 
 *
 *  Gmsh tutorial 9
 * 
 *  Post-processing plugins (levelsets, sections, annotations)
 *
 *********************************************************************/

// Plugins can be added to Gmsh in order to extend its
// capabilities. For example, post-processing plugins can modify a
// view, or create a new view based on previously loaded
// views. Several default plugins are statically linked with Gmsh,
// e.g. Isosurface, CutPlane, CutSphere, Skin, Transform or Smooth.
// Plugins can be controlled in the same way as other options: either
// from the graphical interface (right click on the view button, then
// `Plugins'), or from the command file.

// Let us for example include a three-dimensional scalar view:

Include "view1.pos" ; // troquei porque não há view3.pos na página.

// We then set some options for the `Isosurface' plugin (which
// extracts an isosurface from a 3D scalar view), and run it:

Plugin(Isosurface).Value = 0.67 ; // iso-value level
Plugin(Isosurface).View = 0 ; // source view is View[0]
Plugin(Isosurface).Run ; // run the plugin!

// We also set some options for the `CutPlane' plugin (which computes
// a section of a 3D view using the plane A*x+B*y+C*z+D=0), and then
// run it:

Plugin(CutPlane).A = 0 ; 
Plugin(CutPlane).B = 0.2 ; 
Plugin(CutPlane).C = 1 ; 
Plugin(CutPlane).D = 0 ; 
Plugin(CutPlane).View = 0 ;
Plugin(CutPlane).Run ; 

// Add a title (By convention, for window coordinates a value greater
// than 99999 represents the center. We could also use
// `General.GraphicsWidth / 2', but that would only center the string
// for the current window size.):

Plugin(Annotate).Text = "A nice title" ; 
Plugin(Annotate).X = 1.e5;
Plugin(Annotate).Y = 50 ; 
Plugin(Annotate).Font = "Times-BoldItalic" ; 
Plugin(Annotate).FontSize = 28 ; 
Plugin(Annotate).Align = "Center" ; 
Plugin(Annotate).View = 0 ;
Plugin(Annotate).Run ; 

Plugin(Annotate).Text = "(and a small subtitle)" ; 
Plugin(Annotate).Y = 70 ; 
Plugin(Annotate).Font = "Times-Roman" ; 
Plugin(Annotate).FontSize = 12 ; 
Plugin(Annotate).Run ; 

// We finish by setting some options:

View[0].Light = 1;
View[0].IntervalsType = 1;
View[0].NbIso = 6;
View[0].SmoothNormals = 1;
View[1].IntervalsType = 2;
View[2].IntervalsType = 2;