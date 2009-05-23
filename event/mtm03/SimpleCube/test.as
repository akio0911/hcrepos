// forked from endless's CubeTest
package {
    import org.papervision3d.view.BasicView;
    import org.papervision3d.objects.primitives.Cube;
    import org.papervision3d.materials.utils.MaterialsList;
    import org.papervision3d.materials.ColorMaterial;
    import flash.events.Event;
    
    public class Pv3dSample02 extends BasicView {
        private var cube:Cube;
        
        public function Pv3dSample02() {
            createCube();
            stage.addEventListener(Event.ENTER_FRAME, fHandle);
        }
        
        private function createCube():void {
            var materialsList:MaterialsList = new MaterialsList({
                front:    new ColorMaterial(0x0000FF, 1),
                back:     new ColorMaterial(0x000FF0, 1),
                right:    new ColorMaterial(0x00FF00, 1),
                left:     new ColorMaterial(0x0FF000, 1),
                top:      new ColorMaterial(0xFF0000, 1),
                bottom:   new ColorMaterial(0xFFFF00, 1)
            });
            cube = new Cube(materialsList, 300, 300, 300, 1, 1, 1);
            scene.addChild(cube);
            startRendering();
        }
        
        private function fHandle(evt:Event):void {
            cube.rotationX += 1;
            cube.rotationY += 2;
            cube.rotationZ += 3;
        }
    }
}