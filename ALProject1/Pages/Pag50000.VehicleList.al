page 50000 "Vehicle List"
{
    ApplicationArea = All;
    Caption = 'Vehicle List';
    PageType = List;
    SourceTable = Vehicle;
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field(VIN; Rec.VIN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VIN field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Transmission; Rec.Transmission)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transmission field.';
                }
                field("List Price"; Rec."List Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the List Price field.';
                }
                field("Date of Manufacturing"; Rec."Date of Manufacturing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Manufacturing field.';
                }
            }
        }
    }
}
