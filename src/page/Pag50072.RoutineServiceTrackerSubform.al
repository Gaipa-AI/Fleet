page 50072 "Routine ServiceTracker Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Form Line";
    SourceTableView = WHERE("Document Type" = FILTER("Routine Service Tracker"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Equipment Type"; Rec."Equipment Type")
                {
                    Caption = 'Vehicle Type';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    Caption = 'Vehicle No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    Caption = 'Vehicle Name';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    Caption = 'Vehicle RegNo';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                
                field("Service Interval"; Rec."Service Interval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Interval field.', Comment = '%';
                }
                field("Service Date"; Rec."Service Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Date field.', Comment = '%';
                }
                field("Vehicle/Equipment Location"; Rec."Vehicle/Equipment Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle/Equipment Location field.', Comment = '%';
                }
                field("Service KM"; Rec."Service KM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service KM field.', Comment = '%';
                }
                field("Service Hours"; Rec."Service Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Hours field.', Comment = '%';
                }
                // field("Details Of Service Done"; Rec."Details Of Service Done")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Details Of Service Done field.', Comment = '%';
                // }
                field("Next Service Date"; Rec."Next Service Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Next Service Date field.', Comment = '%';
                }
                field("Next Service KM"; Rec."Next Service KM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Next Service KM field.', Comment = '%';
                }
                // field("Next Service Hours"; Rec."Next Service Hours")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Next Service Hours field.', Comment = '%';
                // }
                field("Current Mileage"; Rec."Current Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current vehicle mileage', Comment = '%';
                }
                field("Date of Current Mileage"; Rec."Date of Current Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the current mileage was taken', Comment = '%';
                }
                field("Remaining Mileage to Service"; Rec."Remaining Service Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the current mileage was taken', Comment = '%';
                

                }

            }
        }

    }
}