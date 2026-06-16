page 50048 "External Hire Requests"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "External Hire Request";
    SourceTable = "Form Header";
    SourceTableView = where("Document Type" = filter("External Hire"), "Client Category" = const(EXTERNAL));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
                field("Client Name"; Rec."Client Name")
                {
                    ToolTip = 'Specifies the value of the Client Name field.', Comment = '%';
                }
                field("Client Category"; Rec."Client Category")
                {
                    ToolTip = 'Specifies the value of the Client Category field.', Comment = '%';
                }
                field("Job Location"; Rec."Job Location")
                {
                    ToolTip = 'Specifies the value of the Job Location field.', Comment = '%';
                }
                field("Job Start Date"; Rec."Job Start Date")
                {
                    ToolTip = 'Specifies the value of the Job Start Date field.', Comment = '%';
                }
                field("Job End Date"; Rec."Job End Date")
                {
                    ToolTip = 'Specifies the value of the Job End Date field.', Comment = '%';
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

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec."Client Category" := Rec."Client Category"::EXTERNAL;
    end;
}