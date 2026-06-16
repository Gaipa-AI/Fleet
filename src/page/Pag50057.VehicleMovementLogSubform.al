page 50057 "Vehicle Movement Log Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Form Line";
    SourceTableView = where("Document Type" = const("Vehicle Movement Log"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field("Opening Mileage"; Rec."Opening Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Opening Mileage field.', Comment = '%';
                }
                field("Closing Mileage"; Rec."Closing Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closing Mileage field.', Comment = '%';
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the From field.', Comment = '%';
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination field.', Comment = '%';
                }
                field("Fuel Top-up (Liters)"; Rec."Fuel Top-up (Liters)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fuel Top-up (Liters) field.', Comment = '%';
                }
            }
        }
    }
}