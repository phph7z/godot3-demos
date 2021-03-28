using Godot;

public class HelloWorld : Node2D
{
    // Declare member variables here. Examples:
    private int a = 2;
    private string b = "text";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        GD.Print("Hello from C# to Godot : ");
    }

    public override void _Process(float delta)
    {
    }
}