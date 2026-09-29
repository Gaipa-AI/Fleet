page 50087 "Generator Checklists"
{
    ApplicationArea = All;
    Caption = 'Generator Checklists';
    PageType = List;
    SourceTable = "Form Header";
    UsageCategory = Lists;
    SourceTableView = where("Document Type" = const("Equipment Inspection"));
    CardPageId = "Generator Checklist";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                }
                field("Equipment Model"; Rec."Equipment Model")
                {
                    ToolTip = 'Specifies the value of the Equipment Model field.', Comment = '%';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
                field("Equipment Serial No."; Rec."Equipment Serial No.")
                {
                    ToolTip = 'Specifies the value of the Equipment Serial No. field.', Comment = '%';
                }
                field(Capacity; Rec.Capacity)
                {
                    ToolTip = 'Voltage capacity of generator';
                }
                field("Current Hours"; Rec."Current Hours")
                {
                    ToolTip = 'Current hour mileage of equipment';
                }
                field("Inspection Type"; Rec."Inspection Type")
                {
                    ToolTip = 'Specifies the value of the Inspection Type field.', Comment = '%';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the state of the vehicle checked', Comment = '%';
                }
            }
        }
    }
}
