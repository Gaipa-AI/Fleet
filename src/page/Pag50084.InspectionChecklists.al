page 50084 "Inspection Checklists 2"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Inspection Checklist 2";
    Editable = false;
    SourceTable = "Form Header";
    SourceTableView = where("Document Type" = const("Equipment Inspection"));
    Caption = 'Inspection Checklists - Others';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field("Week Start Km's"; Rec."Week Start Km's")
                {
                    ToolTip = 'Specifies the value of the Week Start Km''s field.', Comment = '%';
                    Caption = 'Current Mileage';
                }
                
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                
                field("Equipment No."; Rec."Equipment No.")
                {
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                    Caption = 'Vehicle No.';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                    Caption = 'Vehicle RegNo.';
                }
                field("Equipment Make"; Rec."Equipment Make")
                {
                    ToolTip = 'Specifies the value of the Equipment Make field.', Comment = '%';
                    Caption = 'Vehicle Make';
                }
                field("Week Start Date"; Rec."Week Start Date")
                {
                    ToolTip = 'Specifies the value of the Week Start Date field.', Comment = '%';
                    Caption = 'Inspection Date';
                }
                field("State"; Rec."State")
                {
                    ToolTip = 'Specifies the value of the state of the vehicle checked', Comment = '%';
                    Caption = 'Vehicle State';

                    trigger OnValidate()
                    begin
                        if Rec.State = Rec.State::Fixed then 
                          Editable := false;        
                    end;

                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}
